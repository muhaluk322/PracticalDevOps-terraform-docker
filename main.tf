# main.tf

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
}


variable "db_root_password" {
  type        = string
  default       = "defaultpass"
  #description = "PASS"
}

resource "docker_container" "nginx" {
  image = "nginx:latest"
  name  = "nginx-container"

  #command = ["sh", "-c", "echo 'My First and Lastname: <Your first and lastname>' > /usr/share/nginx/html/index.html"]

  ports {
    internal = 80
    external = 8080
  }

  volumes {
        host_path       = "${path.cwd}/html"
        container_path = "/usr/share/nginx/html"
}
}

# MariaDB Container
resource "docker_container" "mariadb" {
  name  = "mariadb_container"
  image = "mariadb:latest"
  
env = ["MARIADB_ROOT_PASSWORD=${var.db_root_password}"]

  ports {
    internal = 3306
    external = 3306
  }
}

