output "controllers_ips" {
  value = tomap({"controllers" = local.controller_ips})
}

output "workers_ips" {
  value = tomap({"workers" = local.worker_ips})
}