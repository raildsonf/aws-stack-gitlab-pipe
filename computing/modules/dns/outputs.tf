output "certificate_arn" {
  value = aws_acm_certificate_validation.dns.certificate_arn
}

output "site" {
  value = aws_route53_record.www.fqdn
}