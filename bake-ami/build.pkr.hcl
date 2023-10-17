build {
  name = "docker-ami-build"
  source "source.amazon-ebs.ami-docker" {
    ssh_username = "ec2-user"
  }
  provisioner "ansible" {
    user          = "ec2-user"
    playbook_file = "./docker.yml"
    use_proxy = false
  }

}
