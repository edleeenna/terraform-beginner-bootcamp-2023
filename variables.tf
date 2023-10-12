variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_access_token" {
  type = string
}

variable "terratowns_endpoint" {
  type = string
}

variable "home_one" {
  type = object({
    public_path = string
    content_version = string

  })
}

variable "home_two" {
  type = object({
    public_path = string
    content_version = string

  })
}