inputs = {
  environment                       = "prod" #split("/", get_terragrunt_dir())[length(split("/", get_terragrunt_dir()))-2]
  profile                          = "tfp"
  region                            = "eu-west-1"
  csoc_aws_account_id            = "920416911834"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
    region = "eu-west-1"
}
EOF
}
