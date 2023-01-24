resource "aws_instance" "linux_instance" {
  name           = "linux-instance"
  //instance_count = var.instance_count

  ami           = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.sg_linux.id]
  subnet_id              = module.vpc.public_subnets[1]

  tags = var.instance_tags
}