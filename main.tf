locals {
  aws_regions = {
    seoul    = "ap-northeast-2"
    virginia = "us-east-1"
    tokyo    = "ap-northeast-1"
  }
}

provider "aws" {
  for_each = local.aws_regions
  alias    = "by_region"

  region  = each.value
  profile = "terraform"
}

resource "aws_vpc" "this" {
  for_each = local.aws_regions
  provider = aws.by_region[each.key]

  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${each.key}-vpc"
  }
}
