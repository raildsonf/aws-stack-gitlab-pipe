data "template_file" "docker" {
    template = file("${path.module}/user-data.tpl")
    vars = {
        docker_map_port = var.docker_map_port
        docker_image    = var.docker_image
        app = var.app
    }
}