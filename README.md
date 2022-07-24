### Aws_course_Project

## How to provision 2-tier infrastructure in AWs using terraform modules

This is an AWs course project involving 2-tier infrastructure provisioning that comprises of security group, private_subnet, public_subnet, loadbalancers,
Auto-Scalling all done using terraform.In this project i used heavily terraform modules to manage the terraform files created during the project lifecycle.
The first thing idid for this project was make sure my AWs IAM usser created with access_key and secret_key used for the terrform project from aws were propertly 
configured using Aws cli.

## USAGE
As a first step, install terraform (see: https://www.terraform.io/downloads)) and select your machine version if its windows and if its mac you can select accordingly
 and install the requirements:

Then download and install AWs CLI
Installation requirements
We support the AWS CLI on Microsoft-supported versions of 64-bit Windows.

Admin rights to install software

Install or update the AWS CLI
To update your current installation of AWS CLI on Windows, download a new installer each time you update to overwrite previous versions. AWS CLI is updated regularly. To see when the latest version was released, see the AWS CLI changelog on GitHub.

Download and run the AWS CLI MSI installer for Windows (64-bit):

https://awscli.amazonaws.com/AWSCLIV2.msi

Alternatively, you can run the msiexec command to run the MSI installer.

C:\> msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
For various parameters that can be used with msiexec, see msiexec on the Microsoft Docs website.

To confirm the installation, open the Start menu, search for cmd to open a command prompt window, and at the command prompt use the aws --version command.

C:\> aws --version
aws-cli/2.4.5 Python/3.8.8 Windows/10 exe/AMD64 prompt/off
Then next once configured  create maini.tf file  in my vscode IDE and launch terraform and run the code below in:



### Terraform Access Provisioing
provider "aws" {

    profile ="myaws"
    region = "eu-west-2"
}

##### As seen above i worked within my aws account region
module "networking_module" {
    source = "./networking_module"
  
}
module "loadbalancer_module"{

source = "./loadbalancer_module"
publicsg_id="${module.networking_module.publicsg_id}"


#### Process workflow for the project i created a terraform workspace as shown below to indentify the various enviroment worked on in the project

$ terraform workspace new Stagging
$ terraform workspace new Production

If there are certain files that will be needed by all the modules then i created such files within the shared_vars module
$mkdir shared_vars
I  then recalled it within the local block in my terraform files as shown below all with default vpc for each of the valaibilty zone used
locals {
       env = "${terraform.workspace}"

       vpcid_env ={

       default="vpc-9e87aff6"
       stagging="vpc-9e87aff6"
       production="vpc-9e87aff6"
       }
       
       }

I then created two publicsubnetid1 , publicsubnetid2 and one privatesubnet1 while also map it as lookup with
local.env(showing the the terraform workspace in all the enviroment workd in)
 
 Below shows the sample code shown with the variouse defaults subnet from aws 
 publicsubnetid1_env ={

 default="subnet-98dba5e2"
 stagging="subnet-98dba5e2"
 production="subnet-98dba5e2"

}
publicsubnetid1="${lookup(local.publicsubnetid1_env,local.env)}"

Next i created the Network_module housing the Network_module.tf, 
This file contains all the resources that has to do with the security group, these are the privatesg and publicsg and they both have 
each own ingreess ruless and egress rules as shown in the modules.It also has vpcid and all the output id of the security group as shown.


Next i created the Loadbalancer_module housing the Loadbalancer_module.tf files this file houses the application load balancer resource,
the target group resource and the loadbalacer listener resource.The snippet of the code are shown below the complete code is in the variouse 
desgnated  code in the github repository.

resource "aws_lb" "sampleapp_alb" {}

resource "aws_lb_listener" "http_listener_80" {}

In this same module i called up the shared_var module as shown below

module "shared_vars"{
  source ="../shared_vars"

}


resource "aws_lb_target_group" "sampleapp-http-tg" {}

Next i created the .gitignore file  to house all the files that i dont want to upload to github the files,they are shpow below

.terraform*
terraform/
terraform.tfstate.backup
terraform.tfstate
terraform/lock.hcl

