# S3
terraform{
	backend "s3"{
		bucket="terraform-13-07-42-state"
		key="global/test/terraform.tfstate"
		region="eu-west-1"
		dynamodb_table="terra-locks"
		encrypt=true
	}
	
}

provider "aws"{
	profile="k8s"
	region="eu-west-1"
}
#-----------------------SG-------------------------- 
resource "aws_security_group" "dynamic"{

	vpc_id=local.vpc	
	name="my-dynamic-sg"
}
resource "aws_security_group_rule" "allow_ssh"{
	type="ingress"
	security_group_id=aws_security_group.dynamic.id
	from_port=22
	to_port=22
	protocol="tcp"
	cidr_blocks=["0.0.0.0/0"]
}
#--------------------------------------------------

resource "aws_instance" "slave"{
	ami="ami-0a8e758f5e873d1c1"
	instance_type="t2.micro"
	vpc_security_group_ids=[aws_security_group.dynamic.id]
	subnet_id=local.subnet
	#userdata="${file('server.sh')}"
	key_name="k8s"
	count=2
	tags={
		Name= "slave-${count.index + 1}"
	}
}


resource "aws_instance" "master"{
	ami="ami-0a8e758f5e873d1c1"
	instance_type="t2.micro"
	vpc_security_group_ids=[aws_security_group.dynamic.id]
	subnet_id=local.subnet
	#userdata="${file('server.sh')}"
	key_name="k8s"
}


output "master"{
	value=aws_instance.master.public_ip
}
output "slave"{
	value=aws_instance.slave.*.public_ip
}
