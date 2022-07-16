

output "vpcid" {
  value="${local.vpcid}"
}
output "public_vpcid" {
  value="${local.public_vpcid}"
}
output "private_vpcid" {
  value="${local.private_vpcid}"
}

output "env_suffix" {
  value="${local.env}"
}

locals {
       env = "${terraform.workspace}"

       vpcid_env ={

       default="vpc-9e87aff6"
       stagging="vpc-9e87aff6"
       production="vpc-9e87aff6"

}
vpcid="${lookup(local.vpcid_env,local.env)}"


publicsubnetid_env ={

 default="subnet-98dba5e2"
 stagging="subnet-98dba5e2"
 production="subnet-98dba5e2"

}
public_vpcid="${lookup(local.publicsubnetid_env,local.env)}"


privatesubnetid_env ={

 default="subnet-4356da0f"
 stagging="subnet-4356da0f"
 production="subnet-4356da0f"

}
private_vpcid="${lookup(local.privatesubnetid_env ,local.env)}"

}