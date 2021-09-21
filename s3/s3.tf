provider  "aws" {
	region="eu-west-1"
	profile="k8s"
}

resource "aws_s3_bucket" "tf_state"{
	bucket="terraform-13-07-42-state"
	force_destroy=true
	server_side_encryption_configuration{
		rule{
			apply_server_side_encryption_by_default{
				sse_algorithm="AES256"
			}
		}
	}
}
resource "aws_dynamodb_table" "tf_locks"{
	name="terra-locks"
	billing_mode="PAY_PER_REQUEST"
	hash_key="lockID"
	attribute{
		name="lockID"
		type="S"
	}
}

