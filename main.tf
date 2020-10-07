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

  api_subdomain = "api"

  stages = ["nonlive", "live"]

  nonlive = {
    domain = "scaffoldly.dev"
  }

  live = {
    domain = "scaffold.ly"
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

# module "bootstrap" {
#   source = "../terraform-scaffoldly-bootstrap"

#   organization = data.external.git.result.organization
#   github_token = var.BOOTSTRAP_GITHUB_TOKEN
# }
