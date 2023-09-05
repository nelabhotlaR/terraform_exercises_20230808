output "ses_arn" {
  value = aws_ses_domain_identity.example.arn
}

output "aws_ses_receipt_rule_set_name" {
  value = aws_ses_receipt_rule_set.rule_set.rule_set_name
}