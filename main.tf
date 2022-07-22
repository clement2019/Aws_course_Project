provider "aws" {

    profile ="myaws"
    region = "eu-west-2"
}

module "networking_module" {
    source = "./networking_module"
  
}
module "loadbalancer_module"{

source = "./loadbalancer_module"
publicsg_id="${module.networking_module.publicsg_id}"
}


