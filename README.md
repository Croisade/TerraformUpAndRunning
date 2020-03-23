# terraform-up-and-running
##Chapter 1
Software delivery - consists of all the work you need to do to make the code available to a customer.
Developers("Devs") - Dedicated to writing the software
Opeartions("Ops") - Dedidated to managing this hardware
Snowflake Servers - Where each one has a subtly different configuration from all the others aka configuration drift.

**The Goal of DevOps is to make software delivery vastly more efficient**

IAC - Treat all aspects of operations as software
Indempotence - Code that works correctly no matter how many times you run it. 

######Configuration Management vs Provisioning
Chef, puppet, Ansible, Saltstack are all configuation management tools
CloudFormation, Terraform and OpenStak Heat are all provisioning tools.

Even though Ansible can deploy servers and Terraform can configure servers you typically want to pick the tool that's the best fit for your use case.

Server templating tools like Docker eliminate the need for configuration management. Once you have a Docker image all that's left to do is to run the image.

######Procedural vs Declarative
Chef and Ansible have a procedural style in which code executes step by step
Terraform, CloudFormation, SaltStack, Puppet have a more declarative style that specifies the desired end state. 

Procedural code does not fully capture the state of the infrastructure and procedural code limits reusability. If you were to run a playbook that creates 15 EC2 instances and then run it again it would add 15 more EC2 instances. This is not the case in Terraform. Terraform keeps track of the state of the infrastructure. To manage a Ansible configuration, you have to know the full history of every change that has happened.

######Master Server
Chef, Puppet, SaltSTack require that you run a master server for storing the state of infrastucture and updates
Ansible, CloudFormation, Heat and Terraform are all masterless by default

######Agent Vs Agentless
Chef, Puppet, and SaltStack requirie you to install agent software
Ansible, CloudFormation, Heat and Terraform do not require you to install agents

######Provisioning plus configuration management
You can use Terraform to deploy all of the infrastructure and then use Ansible to deploy the apps on top of the servers.
