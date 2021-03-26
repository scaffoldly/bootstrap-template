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
  version = "0.14.33"

  root_email   = var.ROOT_EMAIL
  github_token = var.BOOTSTRAP_GITHUB_TOKEN
  organization = data.external.git.result.organization

  # For the various configurations of this:
  # https://docs.scaffold.ly/infrastructure/configuration-files/stages
  stages = {
    nonlive = {
      domain           = "myproject.com"
      subdomain_suffix = "dev"
    }

    live = {
      domain = "myproject.com"
    }
  }

  serverless_apis = {
    service1 = {
      # URL will be: https://sly-dev.myproject.com/service1 and https://sly.myproject.com/service1
      template = "scaffoldly/sls-rest-api-template"
    }
    # Add as many services as you like...
  }

  public_websites = {
    app = {
      # URL will be: https://app-dev.myproject.com and https://app.myproject.com
      template = "scaffoldly/web-angular-template"
    }
    # Add as many websites as you like...
  }

  shared_env_vars = {
    "ENV_VAR_1" = "EnvVar1Value"
  }
}
