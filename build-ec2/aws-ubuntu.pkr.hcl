packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "VPC_ID" {
  type = string
}

variable "SUBNET_ID" {
  type = string
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "node-app-{{isotime \"2006-01-02-1504\"}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  vpc_id        = "${var.VPC_ID}"
  subnet_id     = "${var.SUBNET_ID}"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "node-app"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "ansible" {
    playbook_file = "ansible/playbooks/playbook.yml"
    extra_arguments = [
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
}