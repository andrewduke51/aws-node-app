locals {
  ctrl_user_data = base64encode(templatefile("${path.module}/templates/user_data.sh.tmpl", {
    INIT                = "placeholder"
    ENV                 = var.env
  }))
}

## ec2 instance ##
module "ec2" {
  source          = "git::https://github.com/andrewduke51/aws_modules.git//ec2?ref=v1.5"
  ec2             = 0
  instance_type   = var.instance_type
  security_groups = [aws_security_group.allow_ips.id]
  subnet_id       = module.vpc.subnet_internal
  user_data       = local.ctrl_user_data
  tag_name        = "node-app"
  ami_id          = data.aws_ami.ec2.id
}

## SECURITY GROUP ##
resource "aws_security_group" "allow_ips" {
  name        = "allow_http"
  description = "Allow inbound traffic origin"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}