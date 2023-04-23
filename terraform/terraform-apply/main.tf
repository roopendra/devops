provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

provider "random" {}

provider "time" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "random_pet" "nginx" {
  length = 2
}

resource "docker_container" "nginx" {
  count = 4
  image = docker_image.nginx.latest
  name  = "nginx-${random_pet.nginx.id}-${count.index}"

  ports {
    internal = 80
    external = 8000 + count.index
  }
}
