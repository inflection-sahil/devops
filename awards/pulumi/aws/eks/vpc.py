import pulumi_aws as aws
import values

vpc = aws.ec2.Vpc(
    'vpc',
    
    cidr_block = '10.0.0.0/16',
    instance_tenancy = 'default',
    enable_dns_hostnames = True,
    enable_dns_support = True,

    tags = {
        'Name': values.vpc_properties["vpc-name"]
    }
)

igw = aws.ec2.InternetGateway(
    'vpc-igw',

    vpc_id = vpc.id,
    
    tags = {
        'Name': values.vpc_properties['vpc-igw-name']
    }
)

vpc_public_rt = aws.ec2.RouteTable(
    'vpc-public-rt',
    
    vpc_id = vpc.id,
    routes = [
        aws.ec2.RouteTableRouteArgs(
            cidr_block = '0.0.0.0/0',
            gateway_id = igw.id,
        )
    ],
    
    tags={
        'Name': values.vpc_properties['vpc-public-rt-name']
    }
)

vpc_private_rt = aws.ec2.RouteTable(
    'vpc-private-rt',

    vpc_id = vpc.id,

    tags = {
        'Name': values.vpc_properties['vpc-private-rt-name']
    }
)

# Subnets, one for each AZ in a region
zones = aws.get_availability_zones()
public_subnet_ids = []
private_subnet_ids = []

for zone in zones.names:
    vpc_public_subnet = aws.ec2.Subnet(
        f'vpc-public-subnet-{zone}',
        
        vpc_id = vpc.id,
        cidr_block = f'10.0.{len(public_subnet_ids)}.0/24',
        availability_zone = zone,
        map_public_ip_on_launch = True,

        tags = {
            'Name': f'{values.vpc_properties["vpc-public-subnet-name"]}-{zone}'
        }
    )

    vpc_private_subnet = aws.ec2.Subnet(
        f'vpc-private-subnet-{zone}',

        vpc_id = vpc.id,
        cidr_block = f'10.0.{len(private_subnet_ids)+100}.0/24',
        availability_zone = zone,

        tags = {
            'Name': f'{values.vpc_properties["vpc-private-subnet-name"]}-{zone}'
        }
    )

    aws.ec2.RouteTableAssociation(
        f'vpc-public-rt-assoc-{zone}',
        
        route_table_id = vpc_public_rt.id,
        subnet_id = vpc_public_subnet.id
    )

    aws.ec2.RouteTableAssociation(
        f'vpc-private-rt-assoc-{zone}',

        route_table_id = vpc_private_rt.id,
        subnet_id = vpc_private_subnet.id
    )

    public_subnet_ids.append(vpc_public_subnet.id)
    private_subnet_ids.append(vpc_private_subnet.id)