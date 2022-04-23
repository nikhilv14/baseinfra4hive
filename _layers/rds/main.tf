data "aws_caller_identity" "current" {}

resource "aws_security_group" "hive_sg" {
  name        = "${var.environment}-${var.name}-sg"
  description = "Allow outbound traffic only"
  vpc_id      = "${var.vpcid}"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    NAME = "allow-theHiveComponents-${var.environment}-${var.name}"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = var.ec2s #toset(["theHive", "cortex", "misp"])

  name = "instance-${each.key}"

  ami                    = lookup(each.value, "ami", null)
  instance_type          = lookup(each.value, "instancetype", null)
  key_name               = lookup(each.value, "keyname", null)
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.hive_sg.id] #["sg-12345678"]
  subnet_id              = var.subnetid

  tags = {
    Environment = "prod"
  }
}
