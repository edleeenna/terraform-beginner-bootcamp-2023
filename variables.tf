 variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})$", var.user_uuid))
    error_message = "Invalid user UUID format. Please provide a valid UUID."
  }
}