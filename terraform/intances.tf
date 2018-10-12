variable "aws_region" {
  default = "eu-west-1"
}

variable "aws_secret_key" {
  default = ""
}

variable "aws_access_key" {
  default = ""
}

variable "security_group" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "key_pair" {
  default = ""
}

provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-stretch-hvm-x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"]
}

resource "aws_instance" "app1" {
  ami             = "${data.aws_ami.debian.id}"
  security_groups = ["${var.security_group}"]
  subnet_id       = "${var.subnet_id}"
  instance_type   = "t2.micro"
  key_name        = "${var.key_pair}"

  tags {
    Name = "app1"
  }
}

resource "aws_instance" "dbmaster" {
  ami             = "${data.aws_ami.debian.id}"
  security_groups = ["${var.security_group}"]
  subnet_id       = "${var.subnet_id}"
  instance_type   = "t2.micro"
  key_name        = "${var.key_pair}"

  tags {
    Name = "dbmaster"
  }
}

resource "aws_instance" "dbslave" {
  ami             = "${data.aws_ami.debian.id}"
  security_groups = ["${var.security_group}"]
  subnet_id       = "${var.subnet_id}"
  instance_type   = "t2.micro"
  key_name        = "${var.key_pair}"

  tags {
    Name = "dbslave"
  }
}

output "app1_ip" {
  value = "${aws_instance.app1.public_ip}"
}

output "dbmaster_ip" {
  value = "${aws_instance.dbmaster.public_ip}"
}

output "dbslave_ip" {
  value = "${aws_instance.dbslave.public_ip}"
}

output "dbmaster_private_ip" {
  value = "${aws_instance.dbmaster.private_ip}"
}

output "dbslave_private_ip" {
  value = "${aws_instance.dbslave.private_ip}"
}

output "app1_private_ip" {
  value = "${aws_instance.app1.private_ip}"
}
