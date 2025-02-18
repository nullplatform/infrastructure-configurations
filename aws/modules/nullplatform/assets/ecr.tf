module "ecr" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/provider/asset/ecr"

  nrn                                   = var.nrn
  region                                = var.region
  build_workflow_user_access_key_id     = var.build_workflow_user_access_key_id
  build_workflow_user_secret_access_key = var.build_workflow_user_secret_access_key

  application_manager_role = var.application_manager_role
}
