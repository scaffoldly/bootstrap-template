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
      domain                   = "scaffoldly.dev"
      serverless_api_subdomain = "sls"
    }

    live = {
      domain                   = "scaffoldly.com"
      serverless_api_subdomain = "sls"
    }
  }

  static_websites = {
    example = {
      subdomain = "example" # TODO Support missing or empty string
    }
  }

  serverless_apis = {
    example = {
      aws_services = {
        produces = ["dynamodb"]
      }
      cors = "*" # Todo Support missing or empty string
    }
  }

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

