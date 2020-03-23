provider "aws" {
	region = "us-east-2"
}

resource "aws_db_instance" "example" {
	identifier_prefix = "terraform-up-and-running"
	engine = "mysql"
	allocated_storage = 10
	instance_class = "db.t2.micro"
	name = "example_database"
	username = "admin"

	password = "changeme123"
}
#data "aws_secretsmanager_secret_version" "db_password" {
#	secret_id = "rds-password"
#}
terraform {
	backend "s3" {
		bucket = "up-and-running-tloj-golden"
		key = "data-stores/mysql/terraform.tfstate"
		region = "us-east-2"

		dynamodb_table = "terraform-up-and-running-locks"
		encrypt = true
	}
}
