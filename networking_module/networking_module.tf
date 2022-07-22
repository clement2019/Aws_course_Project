


module "shared_vars"{
source = "../shared_vars"

}



resource "aws_security_group" "publicsg" {
    name ="publicsg_${module.shared_vars.env_suffix}"
    description = "publicsg ELB ${module.shared_vars.env_suffix}"

 vpc_id = "${module.shared_vars.vpcid}"
 ingress {

   
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"


  }

  egress {

    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"


  }
  

}

resource "aws_security_group" "privatesg" {
     name ="privatesg_${module.shared_vars.env_suffix}"
    description = "privatesg for EC2 ${module.shared_vars.env_suffix}"

 vpc_id = "${module.shared_vars.vpcid}"
 ingress {

    security_groups = ["${aws_security_group.publicsg.id}"]
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"


  }

  egress {

    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"


  }
  

}
output "publicsg_id" {
  value = "${aws_security_group.publicsg.id}"
  
}
output "privatesg_id" {
  value = "${aws_security_group.privatesg.id}"
  
}