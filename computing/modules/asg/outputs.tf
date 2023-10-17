output "id" {
  value = aws_autoscaling_group.main.id
}

output "security_group_asg" {
  value = aws_security_group.asg.id
}