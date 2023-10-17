output "dns_name" {
  value = aws_lb.main.dns_name
}

output "dns_zone_id" {
  value = aws_lb.main.zone_id
}

output "security_group_alb" {
  value = aws_security_group.alb.id
}

output "lb_target_group" {
    value = aws_lb_target_group.main.arn
}