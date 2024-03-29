# # # # # # # # # # # # # # # # #
# SECURITY GROUP
# # # # # # # # # # # # # # # # #

resource "aws_security_group" "sg_frontend" {
  name   = "sg_jenkins"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}