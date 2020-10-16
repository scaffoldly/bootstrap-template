terraform {
  required_version = ">= 0.13"
  backend "remote" {
    workspaces {
      name = "bootstrap"
    }
  }
}

locals {
  aws_region = "us-east-1"

  stages = {
    nonlive = {
      # change these to suit your own preferences
      # you can also use a completely separate domain you own
      domain                   = "mydomain.com"
      serverless_api_subdomain = "sls-dev" # sls == 'serverless', you could also simply call this "api"
    }

    live = {
      # change these to suit your own preferences
      domain                   = "mydomain.com"
      serverless_api_subdomain = "sls"
    }
  }

  # TODO: Not yet supported
  static_websites = {
    mywebsite = {}
  }

  serverless_apis = {
    # Update 'myservice1' to be the desired name of your service
    # add as many microservices as you like!
    myservice1 = {
      # TODO: Custom permissions not yet supported
      aws_services = {
        produces = ["dynamodb"]
      }
      # TODO: CORS customization not yet supported
      cors = "*"
    }

    myservice2 = {
      # TODO: Custom permissions not yet supported
      aws_services = {
        produces = ["dynamodb"]
      }
      # TODO: CORS customization not yet supported
      cors = "*"
    }
  }

  # TODO: Adding contributors not yet supported
  contributors = ["cnuss"]
}

module "bootstrap" {
  source = "github.com/scaffoldly/terraform-scaffoldly-bootstrap"

  root_email   = var.ROOT_EMAIL
  github_token = var.BOOTSTRAP_GITHUB_TOKEN
  organization = data.external.git.result.organization

  stages  = local.stages
  nonlive = local.nonlive
  live    = local.live

  aws_region      = local.aws_region
  api_subdomain   = local.api_subdomain
  serverless_apis = local.serverless_apis
}

