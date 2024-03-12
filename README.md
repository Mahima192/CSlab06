Terraform AWS Security Lab

This project is a simple lab to demonstrate how to use Terraform to create a basic AWS infrastructure with security best practices in mind. The infrastructure includes a VPC, a subnet, an EC2 instance, and an S3 bucket with other supporting resources. I configured the EC2 instance with a role that allows it to securely access the S3 bucket.

Basic Setup for this project
For this lab, I ensured that I had the following prerequisites:

An AWS account with the necessary permissions to create the resources in the lab.
AWS CLI configured with the necessary credentials.

1. AWS Account Setup and Requirements
Before starting, I made sure that I had an AWS account with the required permissions to create resources. If I hadn't already, I configured my AWS CLI with the necessary credentials.

2. Terraform Setup and Requirements
I made sure to have Terraform installed on my machine. I checked if Terraform was installed by running the following command:

   terraform --version
   
If Terraform was installed, I saw the version information.
4. Deploying the Infrastructure
To deploy the infrastructure, I followed these steps:

I cloned this repository to my local machine.
I navigated to the directory containing the Terraform files.
I initialized the project by running:

    terraform init
To validate the code this command was used:

    terraform validate
for planning the resources in the terraform and following command was used and when the errors appeared they were also resolved:

    terraform plan
I applied the Terraform configuration to create the infrastructure:

    terraform apply
I followed the prompts and confirmed the changes to proceed with the deployment.

to check i also entered terraform statelist|nl to get the resources deployed.

4. Removing Policies and Roles from AWS
   To remove the EC2 policy and role created in the lab, I followed these steps:
  I retrieved the necessary information from Terraform outputs.
  I used the AWS CLI to detach the policy, remove the role from the instance profile, delete the instance   profile, and delete the IAM role.

6. Destroying the Infrastructure
To destroy the infrastructure and clean up resources, I ran:

    terraform destroy
I confirmed the destruction by typing 'yes' when prompted.
