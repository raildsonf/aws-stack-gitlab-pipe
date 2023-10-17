module "alb" {
  source             = "./modules/alb"
  app                = "ec2-hello"
  vpc                = var.vpc
  subnet_ids         = var.subnet_ids
  security_group_asg = module.asg.security_group_asg
  certificate_arn    = module.dns.certificate_arn
}

module "asg" {
  source                 = "./modules/asg"
  app                    = "ec2-hello"
  docker_image           = "rfelipe17/hello-app:c4b74666"
  docker_map_port        = "80:8080"
  ec2_instance_type      = var.ec2_instance_type
  vpc                    = var.vpc
  subnet_ids             = var.subnet_ids
  aws_key_pair           = var.aws_key_pair
  aws_security_group_alb = module.alb.security_group_alb
  lb_target_group        = module.alb.lb_target_group
}

module "dns" {
  source        = "./modules/dns"
  domain_name   = var.domain_name
  zone_name     = var.zone_name
  record_name   = var.record_name
  alias_name    = module.alb.dns_name
  alias_zone_id = module.alb.dns_zone_id
}
