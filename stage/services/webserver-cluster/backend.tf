terraform {
	backend "s3" {
		bucket = "up-and-running-tloj-golden"
		key = "services/webserver-cluster/terraform.tfstate"
		region = "us-east-2"

		dynamodb_table = "terraform-up-and-running-locks"
		encrypt = true
	}
}
