# ITGix Terraform modules

This Terraform module is used to create AWS Identity Center with users, groups and permission sets

basic example : 
```
data "aws_ssoadmin_instances" "identity_store" {}

module "aws_identitystore" {
  source = "git::https://gitlab.itgix.com/itgix-public/terraform-modules/identity-store.git?ref=v1"
  count  = var.enable_identity_center ? 1 : 0

  identity_store_id = tolist(data.aws_ssoadmin_instances.identity_store.identity_store_ids)[0]
  aws_region        = var.aws_region
  users             = var.users
  permission_sets   = var.permission_sets
  groups            = var.groups
```

more detailed examples how to use the module and the format of the users, permission_sets and groups can be found in examples/ directory
