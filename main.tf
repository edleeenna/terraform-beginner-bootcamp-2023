terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
 # cloud {
  #  organization = "edleeennaorg"

   # workspaces {
  #    name = "terra-house-1"
 #   }
#  }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
 # user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
 # index_html_filepath = var.index_html_filepath
 # error_html_filepath = var.error_html_filepath
 # content_version = var.content_version
 # assets_path = var.assets_path
#} 

resource "terratowns_home" "home" {
  name = "How to play Arcanum in 2023!!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with a lot of bugs. Modders have removed all the originals
making this game really fun to play. This is my guide on how to play
  DESCRIPTION
  domain_name = "12sdf43.cloudfront.net"
  town = "gamers-grotto"
  content_version =  1
}