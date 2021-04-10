terraform {
  required_version = ">= 0.14"
  experiments      = [module_variable_optional_attrs]

  backend "remote" {
    workspaces {
      name = "scaffoldly-bootstrap"
    }
  }
}

module "bootstrap" {
  source  = "scaffoldly/bootstrap/scaffoldly"
  version = "0.14.53"

  root_email   = var.ROOT_EMAIL
  github_token = var.BOOTSTRAP_GITHUB_TOKEN
  organization = var.BOOTSTRAP_ORGANIZATION

  auth_service = true

  stages = {
    nonlive = {
      domain = "smartnuss.dev"
    }

    live = {
      domain = "smartnuss.com"
    }
  }
}
