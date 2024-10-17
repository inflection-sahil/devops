import pulumi_aws as aws
import vpc
import values
import json

eks_cluster_role = aws.iam.Role(
    'eks-cluster-role',

    name = values.eks_properties["eks-cluster-role-name"],
    assume_role_policy = json.dumps(
        {
            'Version': '2012-10-17',
            'Statement': [
                {
                    'Action': 'sts:AssumeRole',
                    'Principal': {
                        'Service': 'eks.amazonaws.com'
                    },
                    'Effect': 'Allow'             
                }
            ]
        }
    )
)

aws.iam.RolePolicyAttachment(
    'eks-cluster-role-AmazonEKSClusterPolicy',
    
    role = eks_cluster_role.id,
    policy_arn = 'arn:aws:iam::aws:policy/AmazonEKSClusterPolicy'
)


eks_cluster_sg = aws.ec2.SecurityGroup(
    'eks-cluster-sg',

    vpc_id = vpc.vpc.id,

    ingress = [
        aws.ec2.SecurityGroupIngressArgs(
            from_port = 80,
            to_port = 80,
            protocol = 'tcp',
            cidr_blocks = ['0.0.0.0/0']
        )
    ],
    egress = [
    	{
			"from_port": 0,
			"to_port": 0,
			"protocol": -1,
			"cidr_blocks": ["0.0.0.0/0"]
		}
    ],
    
    tags = {
        'Name': values.eks_properties['eks-cluster-sg-name']
    }
)

eks_cluster = aws.eks.Cluster(
    'eks-cluster',
    
    name = values.eks_properties["eks-cluster-name"],
    role_arn = eks_cluster_role.arn,
    
    vpc_config = aws.eks.ClusterVpcConfigArgs(
        public_access_cidrs = ['0.0.0.0/0'],
        security_group_ids = [
            eks_cluster_sg.id
        ],
        subnet_ids = vpc.public_subnet_ids
    )
)

eks_node_group_role = aws.iam.Role(
    'eks-node-group-role',
    
    name = values.eks_properties["eks-node-group-role-name"],
    assume_role_policy = json.dumps(
        {
            'Version': '2012-10-17',
            'Statement': [
                {
                    'Action': 'sts:AssumeRole',
                    'Principal': {
                        'Service': 'ec2.amazonaws.com'
                    },
                    'Effect': 'Allow',
                }
            ]
        }
    )
)

aws.iam.RolePolicyAttachment(
    'eks-node-group-role-AmazonEKSWorkerNodePolicy',
    
    role = eks_node_group_role.id,
    policy_arn = 'arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy'
)


aws.iam.RolePolicyAttachment(
    'eks-node-group-role-cni-policy-attachment',
    
    role = eks_node_group_role.id,
    policy_arn = 'arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy'
)

aws.iam.RolePolicyAttachment(
    'eks-node-group-role-AmazonEC2ContainerRegistryReadOnly',
    
    role = eks_node_group_role.id,
    policy_arn = 'arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly'
)

eks_nodegroup = aws.eks.NodeGroup(
    'eks-node-group',
    
    node_group_name = values.eks_properties['eks-node-group-name'],
    cluster_name = eks_cluster.name,
    node_role_arn = eks_node_group_role.arn,

    subnet_ids = vpc.public_subnet_ids,
    instance_types = values.eks_properties["eks-instance-types"],
    
    scaling_config = aws.eks.NodeGroupScalingConfigArgs(
        desired_size = 2,
        max_size = 2,
        min_size = 2
    )
)