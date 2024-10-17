import pulumi_aws as aws
import values

s3_bucket = aws.s3.Bucket(
    "s3-bucket",
    
	bucket = values.s3_properties["s3-bucket-name"]
)