data "terraform_remote_state" "network"{
	backend="s3"
	config={
		bucket="terraform-13-07-42-state"
		key="global/network/terraform.tfstate"
		region="eu-west-1"
		dynamodb_table="terra-locks"
		encrypt=true
	}
	
}

locals{
	vpc=data.terraform_remote_state.network.outputs.vpc
	subnet=data.terraform_remote_state.network.outputs.subnet
}
