resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}

resource "aws_organizations_account" "accounts" {
  for_each                   = var.account_map

  name                       = each.key
  email                      = each.value.email
  iam_user_access_to_billing = var.billing_access
  parent_id                  = var.parent_id
  role_name                  = var.role_name
  tags                       = lookup(each.value, "tags", null)

  # There is no AWS Organizations API for reading role_name
  lifecycle {
    ignore_changes = [role_name]
  }

}

output "arn_id_map" {
  description = "The ARN and ID of the new organization account."
  value = {
    for account in aws_organizations_account.accounts:
    account.arn => account.id
  }
}
