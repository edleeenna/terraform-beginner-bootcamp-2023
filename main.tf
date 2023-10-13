terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "edleeennaorg"

    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_one_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.home_one.public_path
  content_version = var.home_one.content_version
 
} 

resource "terratowns_home" "home_one" {
  name = "Why you should watch The Bear!"
  description = <<DESCRIPTION
A young chef from the fine dining world returns to Chicago to run his family's sandwich shop. Carmen Berzatto,
 a brilliant young chef from the fine-dining world is forced to return home to run his local family sandwich shop - the Original Beef of Chicagoland - after a heartbreaking death in his family.
  DESCRIPTION
  domain_name = module.home_one_hosting.domain_name
  town = "video-valley"
  content_version =  var.home_one.content_version
}

#module "home_two_hosting" {
#  source = "./modules/terrahome_aws"
#  user_uuid = var.teacherseat_user_uuid
#  public_path = var.home_two.public_path
#  content_version = var.home_two.content_version
#} 
#

#resource "terratowns_home" "home_two" {
#  name = "Testing Home 2"
#  description = <<DESCRIPTION
#Test Home 2
#  DESCRIPTION
#  domain_name = module.home_two_hosting.domain_name
#  town = "missingo"
#  content_version =  var.home_two.content_version
#}