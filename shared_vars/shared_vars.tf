

output "vpcid" {
  value="${local.vpcid}"
}
output "publicsubnetid1" {
  value="${local.publicsubnetid1}"
}
output "publicsubnetid2" {
  value="${local.publicsubnetid2}"
}
output "privatesubnetid" {
  value="${local.privatesubnetid}"
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


publicsubnetid1_env ={

 default="subnet-98dba5e2"
 stagging="subnet-98dba5e2"
 production="subnet-98dba5e2"

}
publicsubnetid1="${lookup(local.publicsubnetid1_env,local.env)}"

publicsubnetid2_env ={

 default="subnet-b34974da"
 stagging="subnet-b34974da"
 production="subnet-b34974da"

}
publicsubnetid2="${lookup(local.publicsubnetid2_env,local.env)}"

privatesubnetid_env ={

 default="subnet-4356da0f"
 stagging="subnet-4356da0f"
 production="subnet-4356da0f"

}
privatesubnetid="${lookup(local.privatesubnetid_env ,local.env)}"

}