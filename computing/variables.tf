variable "region" {
  type    = string
  default = "us-east-2"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_ids" {
  type    = list(any)
  default = ["subnet-0", "subnet-0", "subnet-0"]
}

variable "vpc" {
  type    = string
  default = "vpc-0"
}

variable "aws_key_pair" {
  type    = string
  default = "awskeypair"
}

variable "record_name" {
  type    = string
  default = "ec2.openbankingpx.tk"
}

variable "zone_name" {
  type    = string
  default = "openbankingpx.tk"
}

variable "domain_name" {
  type    = string
  default = "*.openbankingpx.tk"
}