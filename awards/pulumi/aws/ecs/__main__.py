import pulumi
import pulumi_aws as aws
from commons import vpc, s3, rds, load_balancer, ecs
import values

VPC = vpc(values)
S3 = s3(values)
RDS = rds(values, VPC)
Load_balancer = load_balancer(values, VPC)
ECS = ecs(values, VPC, Load_balancer)

bucket_object = aws.s3.BucketObject(
    "config.env",
    
	bucket = S3.s3_bucket.id,
    source = pulumi.FileAsset(values.s3_properties["s3-env-file-path"])
)