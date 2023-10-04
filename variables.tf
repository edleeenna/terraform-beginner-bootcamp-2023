 variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})$", var.user_uuid))
    error_message = "Invalid user UUID format. Please provide a valid UUID."
  }
}

variable "bucket_name" {
  description = "AWS S3 Bucket Name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "Invalid bucket name. Bucket names must be between 3 and 63 characters and can only contain lowercase letters, numbers, hyphens, and periods. They must start and end with a lowercase letter or number."
  }
}

