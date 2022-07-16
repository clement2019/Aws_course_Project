provider "aws" {

    profile ="myaws"
    region = "eu-west-2"
}

module "networking_module" {
    source = "./networking_module"
  
}