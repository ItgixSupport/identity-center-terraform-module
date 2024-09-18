# Identity Center
# should be enabled only if local users will be used; if external identity providers are planned to be used (such as google workspace, active directory, keycloak, etc) there are separate implementation steps for those in the documentation (outside of Terraform)
enable_identity_center = true
users = [
  #   example
  {
    display_name  = "ITGix Test2"
    user_name     = "itgixtest2"
    given_name    = "Test"
    family_name   = "User2"
    email         = "boris.yakimov@itgix.com"
    primary_email = true
    email_type    = "work"
    groups = [
      "temporary_access_requestors",
      "non-prod-admins"
    ]
  },
  # same example but with read-only persmissions instead of admin
  {
    display_name  = "ITGix Test3"
    user_name     = "itgixtest3"
    given_name    = "Test"
    family_name   = "User3"
    email         = "boris.yakimov@itgix.com"
    primary_email = true
    email_type    = "work"
    groups = [
      "temporary_access_requestors",
      "non-prod-readonly"
    ]
  }
]

permission_sets = [
  # Read Only
  {
    name               = "Non-Prod-ReadOnlyAccess"
    description        = "A permission set with read-only access to Non-Prod accounts"
    session_duration   = "PT2H" # in hours
    managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  },
  {
    name               = "Prod-ReadOnlyAccess"
    description        = "A permission set with read-only access to PROD"
    session_duration   = "PT1H" # in hours
    managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  },
  # Admin - Full Access
  {
    name               = "Prod-AdministratorAccess"
    description        = "A permission set with full access to PROD"
    session_duration   = "PT1H" # in hours
    managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  },
  {
    name               = "Non-Prod-AdministratorAccess"
    description        = "A permission set with full access to Non-Prod accounts"
    session_duration   = "PT2H" # in hours
    managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  },
  #{
  #name               = "BillingAccess"
  #description        = "A permission set access only to billing information"
  #session_duration   = "PT2H" # in hours
  #managed_policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
  #}
]
