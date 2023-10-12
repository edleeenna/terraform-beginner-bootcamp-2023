## Terrahome AWS

The following direct


```tf
module "home_one" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.home_one_public_path
  content_version = var.content_version
 
} 
```

The public directory expects the following:
- index.html
- error.html
- assets

All top level files in assets will be copied, but not any subdirectories.
