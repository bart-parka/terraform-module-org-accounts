#####################################################################################
# Organisation accounts
#####################################################################################
module "aws-account" {
  source              = "github.com/bart-parka/terraform-module-org-accounts.git"

  billing_access     = "ALLOW" #This needs to be allow to allow role-switch users to leave an org
  account_map        = {
    account_2_name = {
        email = "bartparka+demo@gmail.com"
        tags  = {
          account_number = "account_2"
          type           = "Test"
        }
      }
  }

}

#####################################################################################
# IAM group for organisation admins
#####################################################################################
module "assume-role-group" {
  source  = "QuiNovas/assume-role-group/aws"
  version = "3.0.1"
  allowed_user_names = [
    "Bart_parka"
  ]
  name = "OrganisationAdmins"
  role_arns = [
    for account in module.aws-account.arn_id_map:
    "arn:aws:iam::${account}:role/OrganizationAccountAccessRole"
  ]
}