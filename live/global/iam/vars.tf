variable "user_names" {
	description = "create IAM users with these names"
	type = list(string)
	default = ["neo", "trinity", "morpheus"]
}

