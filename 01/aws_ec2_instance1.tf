provider "aws" {
  region     = "${var.region}"
}

resource "aws_key_pair" "cloud_automation_getting_started-key" {
  key_name   = "cloud_automation_getting_started"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCBzmo0l3ly+1xKCAWEQaa4nnzSoP/woy8ws6Ip7urUxi37zxrc8uv9bHgiak+05lg6/jNsr63vMdFLYwChfA/QLKU+UBtaUP0BaIQa57zWTbDah5pn8H2Y8ubWXZL3gKrES8j9Tti4O4mrIQhrIM3GdybeffUFES6B524znoWt977czeNCRaQX4hQEx9GKwUlaf4DTurP3LG2SqkzdwOt2qjpu9OJ2D2lYcIM7lZuk3nnsd/QnH8GrtrupoPmjf1jFGaT7j+QTHsA4SbpIVg9QDKae9p4gRUpc2ru8L41rYvhf3iMVfO9HbD9nbC0ymQuItsnQZONABvY+Q/yLcRP7"
}

resource "aws_vpc" "mainvpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_default_security_group" "default_security_group" {
  vpc_id = "${aws_vpc.mainvpc.id}"

  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 22
    to_port   = 22
    cidr_blocks = ["${var.admin_outside_ip}"]
  }
}

resource "aws_instance" "aws_ec2_instance1" {
  ami           = "${lookup(var.ubuntu_amis, var.region)}"
  instance_type = "t2.micro"
  key_name = "cloud_automation_getting_started"
  vpc_security_group_ids = ["${aws_default_security_group.default_security_group.id}"]
}

resource "aws_eip" "aws_eip1" {
  instance = "${aws_instance.aws_ec2_instance1.id}"
}
