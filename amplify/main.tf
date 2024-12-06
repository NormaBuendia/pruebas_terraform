terraform {
  backend "s3" {}
}

resource "aws_amplify_app" "this" {
  name                = var.app_name
  repository          = var.repository_url
  oauth_token         = var.oauth_token
  build_spec          = var.build_spec
  environment_variables = var.environment_variables
  platform              = var.platform
  enable_branch_auto_build = var.enable_branch_auto_build

  tags = var.tags
}

resource "aws_amplify_branch" "branches" {
  for_each = var.branches

  app_id            = aws_amplify_app.this.id
  branch_name       = each.key
  enable_auto_build = each.value.enable_auto_build
  stage             = each.value.stage
  framework         = each.value.framework

  environment_variables = each.value.environment_variables

  tags = var.tags
}

resource "aws_amplify_domain_association" "domain" {
  app_id       = aws_amplify_app.this.id
  domain_name  = var.custom_domain

  sub_domain {
    branch_name = var.default_branch
    prefix      = ""
  }
}

