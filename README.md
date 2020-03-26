# terraform-up-and-running
## Chapter 1
Software delivery - consists of all the work you need to do to make the code available to a customer.
Developers("Devs") - Dedicated to writing the software
Opeartions("Ops") - Dedidated to managing this hardware
Snowflake Servers - Where each one has a subtly different configuration from all the others aka configuration drift.

**The Goal of DevOps is to make software delivery vastly more efficient**

IAC - Treat all aspects of operations as software
Indempotence - Code that works correctly no matter how many times you run it. 

##### Configuration Management vs Provisioning
Chef, puppet, Ansible, Saltstack are all configuation management tools
CloudFormation, Terraform and OpenStak Heat are all provisioning tools.

Even though Ansible can deploy servers and Terraform can configure servers you typically want to pick the tool that's the best fit for your use case.

Server templating tools like Docker eliminate the need for configuration management. Once you have a Docker image all that's left to do is to run the image.

##### Procedural vs Declarative
Chef and Ansible have a procedural style in which code executes step by step
Terraform, CloudFormation, SaltStack, Puppet have a more declarative style that specifies the desired end state. 

Procedural code does not fully capture the state of the infrastructure and procedural code limits reusability. If you were to run a playbook that creates 15 EC2 instances and then run it again it would add 15 more EC2 instances. This is not the case in Terraform. Terraform keeps track of the state of the infrastructure. To manage a Ansible configuration, you have to know the full history of every change that has happened.

##### Master Server
Chef, Puppet, SaltSTack require that you run a master server for storing the state of infrastucture and updates
Ansible, CloudFormation, Heat and Terraform are all masterless by default

##### Agent Vs Agentless
Chef, Puppet, and SaltStack requirie you to install agent software
Ansible, CloudFormation, Heat and Terraform do not require you to install agents

##### Provisioning plus configuration management
You can use Terraform to deploy all of the infrastructure and then use Ansible to deploy the apps on top of the servers.

## Chapter 2
For each type of provider there are many different resources that can be create like for example servers load balancers and other infrastructure.
The general syntax is
```
provider "aws" {
    region = "us-east-1"
}

resource "<PROVIDER>_<TYPE>" "<NAME>" {
    [CONFIG ...}
}
```

##### Init
When you first use Terraform you need to initialize it with terraform init to scan the code so terraform can figure out which providers you're using.
You need to run init any time you start with new terraform code. init is idempotent so it's okay if you run it multiple times

##### Plan
The plan command will show you what Terraform will do before it actually does anything. 

##### Apply
To actually create the instance run terraform apply
Terraform keeps track of all the resources it has already created.

##### References
Allows us to access values from other parts of our code. To access the a reference we need to use resource attribute reference which uses the following syntax.
```
<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
```
Provider is the name of the provider which would be aws in our case. Type is the type of resource which is something like security group. Name is the name of that resource. Attribute us either one of the arguments of that resource or one of the attributes exported by the resource.

When you add a reference when one resource to another it makes an implicit dependency. Terraform makes a graph of these dependencies to know which order it should create resources.

##### Variables
Input variable Syntax
```
variable "NAME" {
    [CONFIG ...]
}
```

Output Variable Syntax
```
output "<NAME>" {
    value = <VALUE>
    [CONFIG ...]
}
```

Description
    A way to document what type of data is contained in the output variable
    
Sensitive
    Make this true to make Terraform not log this output. This should be used when the output variable contains sensitive information.
    
An example of a output variable would be
```
output "Instance IP" {
    value = aws_isntance.example.public_ip
    description = "the public IP address of the web server"
}
```
##### Data Sources
data sources represent information that is fetched from provider everytime terraform is ran. like EC2 instance facts.
```
data "<PROVIDER>_<TYPE>" "<NAME>"{
    [CONFIG ...}
}
```
```
data "aws_vpc" "default"{
    default = true
}
```

To get the data out of a data source we use the this attribute refernece syntax
```
data.<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
```

To get the ID of the VPC from the aws_vpc data source, you would use this
```
data.aws_vpc.default.id
```

You can combine this with another data source, aws_subnet_ids, to look up the subnets within that VPC:
```
data "aws_subnet_ids" "default" {
    vpc_id = data.aws_vpc.default.id
}
```
