## Output value definitions

output "nginx_hosts" {
  value = [for container in docker_container.nginx : { name : container.name, host : "${container.ports[0].ip}:${container.ports[0].external}" }]
}
