import pulumi
import pulumi_aws as aws
import vpc
import load_balancer
import values
import json

ecs_cluster = aws.ecs.Cluster(
    "ecs-cluster",

	name = values.ecs_properties["ecs-cluster-name"]
)

ecs_role = aws.iam.Role(
    "ecs-task-execution-role",
    
	name = values.ecs_properties["ecs-task-execution-role-name"],
	assume_role_policy = json.dumps(
        {
			"Version": "2008-10-17",
			"Statement": [
                {
					"Effect": "Allow",
					"Principal": {
                        "Service": "ecs-tasks.amazonaws.com"
					},
					"Action": "sts:AssumeRole",
				}
            ]
		}
    )
)

aws.iam.RolePolicyAttachment(
    "ecs-task-execution-role-AmazonECSTaskExecutionRolePolicy",
	
	role = ecs_role.name,
	policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
)

ecs_task_definition = aws.ecs.TaskDefinition(
    "ecs-task",
    
	family = values.ecs_properties["ecs-task-family-name"],
    network_mode = "awsvpc",
    cpu = 512,
    memory = 1024,
	requires_compatibilities = ["FARGATE"],
    execution_role_arn = ecs_role.arn,
    container_definitions = json.dumps(values.ecs_container_definition)
)

ecs_service = aws.ecs.Service(
    "ecs-service",
    
	name = values.ecs_properties["ecs-service-name"],
	cluster = ecs_cluster.arn,
    desired_count = values.ecs_properties["ecs-service-desired-count"],
    launch_type = "FARGATE",
    task_definition = ecs_task_definition.arn,
    
    network_configuration = {
        "assign_public_ip": True,
        "subnets": vpc.public_subnet_ids,
        "security_groups": [load_balancer.load_balancer_sg.id]
	},
    
	load_balancers=[
        {
			"target_group_arn": load_balancer.load_balancer_tg.arn,
			"container_name": values.ecs_properties["ecs-container-name"],
			"container_port": values.ecs_properties["ecs-container-port"]
		}
    ],
    
	opts = pulumi.ResourceOptions(
        depends_on = [
            load_balancer.load_balancer_listner
        ]
    )
)

pulumi.export("url", load_balancer.load_balancer.dns_name)