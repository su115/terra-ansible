# To work with S3
terraform{
	backend "s3"{
		bucket="terraform-13-07-42-state"
		key="global/network/terraform.tfstate"
		region="eu-west-1"
		dynamodb_table="terra-locks"
		encrypt=true
	}
}

# Provider
provider "aws"{
	profile="k8s"
	region="eu-west-1"
}
# ------------- VPS & Subnet --------------------
resource "aws_vpc" "my-vpc"{
	cidr_block="10.0.0.0/16"
}
resource "aws_subnet" "sub1"{
	cidr_block="10.0.20.0/24"
	vpc_id=aws_vpc.my-vpc.id
	map_public_ip_on_launch="true" # to set public ip
}
# ------------ Alow ssh to instance -------------
resource "aws_route_table" "rt"{
	vpc_id=aws_vpc.my-vpc.id
	route{
		cidr_block="0.0.0.0/0"
		gateway_id=aws_internet_gateway.igw.id
	}
}
resource "aws_route_table_association" "art"{
	subnet_id=aws_subnet.sub1.id
	route_table_id=aws_route_table.rt.id
}

resource "aws_internet_gateway" "igw"{
	vpc_id=aws_vpc.my-vpc.id
}
# ------------ Outputs --------------------------
output "vpc"{
	value=aws_vpc.my-vpc.id
}
output "subnet"{
	value=aws_subnet.sub1.id
}
# -----------------------------------------------

