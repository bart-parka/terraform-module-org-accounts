variable "account_map" {
  description = "The map containing name and email address for each account"
  type        = any   
  default     = {}
}

variable "billing_access" {
  description = "Allow IAM users to access account billing information if they have the required permissions."
  type        = string
  default     = "DENY"
}

variable "parent_id" {
  description = "Parent Organizational Unit ID or Root ID for the account."
  type        = string
  default     = null
}

variable "role_name" {
  description = " The name of an IAM role that Organizations automatically preconfigures in the new member account."
  type        = string
  default     = null
}
