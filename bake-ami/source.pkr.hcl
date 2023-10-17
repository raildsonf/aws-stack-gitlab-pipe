source "amazon-ebs" "ami-docker" {
  access_key                  = "${var.access_key}"
  secret_key                  = "${var.secret_key}"
  region                      = "us-east-2"
  subnet_id                   = "subnet-03f"
  security_group_id           = "sg-0b8"
  ami_name                    = "docker-apps-${formatdate("YYYY-MM-DD-hhmmss", timestamp())}"
  source_ami                  = "ami-051dfed8f67f095f5"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  ssh_file_transfer_method    = "scp"
}
