import pulumi
import pulumi_aws as aws
import vpc
import s3 as s3
import rds
import load_balancer
import ecs

bucket_Object = aws.s3.BucketObject(
    "config.env",
    
	bucket = s3.s3_bucket.id,
    source = pulumi.FileAsset("../../../compose/.env")
)