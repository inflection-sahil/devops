import pulumi_aws as aws
import vpc
import values

load_balancer_sg = aws.ec2.SecurityGroup(
    "ecs-sg",
    
	vpc_id = vpc.vpc.id,

	ingress = [
        {
			"from_port": 80,
			"to_port": 80,
			"protocol": "tcp",
			"cidr_blocks": ["0.0.0.0/0"]
		}
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
        'Name': values.load_balancer_properties["load-balancer-sg-name"]
	}
)

load_balancer = aws.lb.LoadBalancer(
    "load-balancer",
    
	name = "lb",
	security_groups = [load_balancer_sg.id],
	subnets = vpc.public_subnet_ids
)

load_balancer_tg = aws.lb.TargetGroup(
    "load-balancer-tg",
    
	name = values.load_balancer_properties["load-balancer-tg-name"],
	port = values.load_balancer_properties["port"],
	protocol = "HTTP",
	target_type = "ip",
	vpc_id = vpc.vpc.id
)

load_balancer_listner = aws.lb.Listener(
    "load-balancer-listener",
	
	load_balancer_arn = load_balancer.arn,
	port = 80,
	default_actions = [
        {
			"type": "forward",
			"target_group_arn": load_balancer_tg.arn
		}
    ]
)