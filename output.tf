output "ip" {
  value = "${aws_eip.aws_eip1.public_ip}"
}