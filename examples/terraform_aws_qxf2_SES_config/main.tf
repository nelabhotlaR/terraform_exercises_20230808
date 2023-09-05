provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_ses_domain_identity" "example" {
  domain = var.domain_name
}

data "aws_iam_policy_document" "ses" {
  statement {
    actions   = ["ses:*"]
    resources = [aws_ses_domain_identity.example.arn]

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }
}

resource "aws_ses_identity_policy" "example" {
  identity = aws_ses_domain_identity.example.arn
  name     = var.name
  policy   = data.aws_iam_policy_document.ses.json
}


resource "aws_ses_receipt_rule_set" "rule_set" {
  rule_set_name = var.rule_set_name
}

resource "aws_ses_receipt_rule" "rule" {
  name          = "all"
  rule_set_name = aws_ses_receipt_rule_set.rule_set.rule_set_name
  recipients    = ["drishya.tm@qxf2.com"]
  enabled       = true
  scan_enabled  = false
}

