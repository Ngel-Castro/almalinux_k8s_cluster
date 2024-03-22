output "controllers_ips" {
<<<<<<< HEAD
  value = tomap({"controllers" = local.controller_ips})
}

output "workers_ips" {
  value = tomap({"workers" = local.worker_ips})
=======
  value = local.controller_ips
}

output "workers_ips" {
  value = local.worker_ips
>>>>>>> main
}