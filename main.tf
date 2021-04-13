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
  version = "0.14.61"

  root_email   = var.ROOT_EMAIL
  github_token = var.BOOTSTRAP_GITHUB_TOKEN
  organization = var.BOOTSTRAP_ORGANIZATION

  stages = {
    nonlive = {
      domain = "myproject.dev"
      # or to suffix nonlive subdomains with '-dev.myproject.com'
      # domain = "myproject.com"
      # subdomain_suffix = "dev"
    }
    live = {
      domain = "myproject.com"
    }
  }
}
