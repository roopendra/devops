terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.7.2"
    }
  }
}
