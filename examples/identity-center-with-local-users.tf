# This module should be used if we intend to use IAM Identity Center with local users
# if we intend to integrate identity center with and external identity provider (such as google workspace) this has separate implementation steps
data "aws_ssoadmin_instances" "identity_store" {}

module "aws_identitystore" {
  source = "git::https://gitlab.itgix.com/itgix-public/terraform-modules/identity-store.git?ref=v1"
  count  = var.enable_identity_center ? 1 : 0

  identity_store_id = tolist(data.aws_ssoadmin_instances.identity_store.identity_store_ids)[0]
  aws_region        = var.aws_region
  users             = var.users
  permission_sets   = var.permission_sets

  # example groups and permission sets to be created
  groups = [
    # Main groups
    {
      display_name = "non-prod-admins" # admin access to non-prod accounts
      description  = "Group of users that have Admin permissions to non-prod accounts"
      accounts = [
        {
          # Shared Services account
          #account_id     = module.aws_organization.shared_services_account_id
          account_id     = "288761741008"
          permission_set = "Non-Prod-AdministratorAccess"
        },
        {
          # Logging and Audit account
          #account_id     = module.aws_organization.audit_account_id
          account_id     = "307946641461"
          permission_set = "Non-Prod-AdministratorAccess"
        },
        {
          # Dev account
          #account_id     = module.aws_organization.dev_account_id
          account_id     = "253490778887"
          permission_set = "Non-Prod-AdministratorAccess"
        },
        {
          # Staging account
          #account_id     = module.aws_organization.stage_account_id
          account_id     = "202533496834"
          permission_set = "Non-Prod-AdministratorAccess"
        }
      ]
    },
    {
      display_name = "prod-admins" # admin access to prod account
      description  = "Group of users that have Admin permissions to Prod account"
      accounts = [
        {
          # Production account
          #account_id     = module.aws_organization.prod_account_id
          account_id     = "216989116389"
          permission_set = "Prod-AdministratorAccess"
        }
      ]
    },
    {
      display_name = "non-prod-readonly"
      description  = "Group of users that have ReadOnly permissions to non-prod accounts"
      accounts = [
        {
          # Shared Services account
          #account_id     = module.aws_organization.shared_services_account_id
          account_id     = "288761741008"
          permission_set = "Non-Prod-ReadOnlyAccess"
        },
        {
          # Logging and Audit account
          #account_id     = module.aws_organization.audit_account_id
          account_id     = "307946641461"
          permission_set = "Non-Prod-ReadOnlyAccess"
        },
        {
          # Dev account
          #account_id     = module.aws_organization.dev_account_id
          account_id     = "253490778887"
          permission_set = "Non-Prod-ReadOnlyAccess"
        },
        {
          # Staging account
          #account_id     = module.aws_organization.stage_account_id
          account_id     = "202533496834"
          permission_set = "Non-Prod-ReadOnlyAccess"
        }
      ]
    },
    {
      display_name = "prod-readonly"
      description  = "Group of users that have ReadOnly permissions to Prod account"
      accounts = [
        {
          # Production account
          #account_id     = module.aws_organization.prod_account_id
          account_id     = "216989116389"
          permission_set = "Prod-ReadOnlyAccess"
        }
      ]
    },
    {
      display_name = "security-admin"
      description  = "Group of users that have Full permissions to Security account"
      accounts = [
        {
          # Security account
          #account_id     = module.aws_organization.shared_services_account_id
          account_id     = "296062573670"
          permission_set = "Non-Prod-ReadOnlyAccess"
        },
      ]
    },
    {
      display_name = "security-readonly"
      description  = "Group of users that have ReadOnly permissions to Security account"
      accounts = [
        {
          # Security account
          #account_id     = module.aws_organization.prod_account_id
          account_id     = "296062573670"
          permission_set = "Non-Prod-ReadOnlyAccess"
        }
      ]
    },
    {
      display_name = "vpn-users"
      description  = "Group of users that have ReadOnly permissions to Security account"
      accounts = [
        {
          # Security account
          #account_id     = module.aws_organization.prod_account_id
          account_id     = "296062573670"
          permission_set = "Non-Prod-ReadOnlyAccess"
        }
      ]
    },
    # Groups for TEAM tool
    # account assignment doesn't matter for the TEAM tool roles as they are used within the tool itself so here they are just assigned with a default account and permission set that does not really do anything
    {
      display_name = "temporary_access_tool_admins" # admins that manage the TEAM tool
      description  = "Group of users that can administer the TEAM tool for temp access"
      accounts = [
        {
          # Shared Services account
          #account_id     = module.aws_organization.shared_services_account_id
          account_id     = "288761741008"
          permission_set = "Non-Prod-ReadOnlyAccess"
        },
      ]
    },
    {
      display_name = "temporary_access_tool_auditors"
      description  = "Group of users that can audit the configuration of the TEAM tool for temp access"
      accounts = [
        {
          # Shared Services account
          #account_id     = module.aws_organization.shared_services_account_id
          account_id     = "288761741008"
          permission_set = "Non-Prod-ReadOnlyAccess"
        },
      ]
    },
    {
      display_name = "temporary_access_approvers" # people that can approve access 
      description  = "Group of users that can approve access requests in the TEAM tool"
      accounts = [
        {
          # Shared Services account
          #account_id     = module.aws_organization.shared_services_account_id
          account_id     = "288761741008"
          permission_set = "Non-Prod-ReadOnlyAccess"
        },
      ]
    },
    {
      display_name = "temporary_access_requestors" # most users will be added here by default
      description  = "Group of users that can submit access requests in the TEAM tool"
      accounts = [
        {
          # Shared Services account
          #account_id     = module.aws_organization.shared_services_account_id
          account_id     = "288761741008"
          permission_set = "Non-Prod-ReadOnlyAccess"
        },
      ]
    }
  ]
}
