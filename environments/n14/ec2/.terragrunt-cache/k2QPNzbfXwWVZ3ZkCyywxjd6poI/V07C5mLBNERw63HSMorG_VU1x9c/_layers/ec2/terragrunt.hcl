include {
  path = find_in_parent_folders()
}

locals {
  n14_vars = yamldecode(file(find_in_parent_folders("n14_vars.yaml")))
  env = "prod" #split("/", get_terragrunt_dir())[length(split("/", get_terragrunt_dir()))-2]
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = local.n14_vars.tf_bucket_name
    key = "${local.env}/${path_relative_to_include()}/terraform.tfstate"
    region         = local.n14_vars.tf_bucket_region
    encrypt        = true
    
  }
}

inputs = {
  name = "thehive"
  ec2s = {
    thehive = {
      ami = "ami-0000bebe516f304b1",
      instancetype = "t2.micro",
      keyname = "nhive"
    },
    cortex = {
      ami = "ami-0000bebe516f304b1",
      instancetype = "t2.micro",
      keyname = "nhive"
    },
    misp = {
      ami = "ami-0000bebe516f304b1",
      instancetype = "t2.micro",
      keyname = "nhive"
    }
  }
  vpcid  = "vpc-0eefc49013f06e45a"
  subnetid = "subnet-08e1d5552de91b5bd"
  
}

terraform {
  source = "../../..//_layers/ec2"
}