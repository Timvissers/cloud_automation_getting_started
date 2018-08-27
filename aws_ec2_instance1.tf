provider "aws" {
  region     = "${var.region}"
}

resource "aws_instance" "aws_ec2_instance1" {
  ami           = "${lookup(var.ubuntu_amis, var.region)}"
  instance_type = "t2.micro"
  depends_on = ["aws_s3_bucket.aws_s3_bucket1"]
}

resource "aws_eip" "aws_eip1" {
  instance = "${aws_instance.aws_ec2_instance1.id}"
}

resource "aws_s3_bucket" "aws_s3_bucket1" {
  bucket = "test.thisisans3bucket1"
  acl    = "private"
}