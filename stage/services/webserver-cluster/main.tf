provider "aws" {
	region = "us-east-2"
}

module "webserver-cluster" {
	source = "../../../modules/services/webserver-cluster"

	cluster_name = "webservers-stage"
	db_remote_state_bucket = "up-and-running-tloj-golden"
	db_remote_state_key = "env:/stage/data-stores/mysql/terraform.tfstate"

	instance_key = "t2.micro"
	min_size = 2
	max_size = 2
}
