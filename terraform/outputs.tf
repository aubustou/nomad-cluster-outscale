output "client-lb" {
  value = "${outscale_public_ip.public.public_ip}"
}

output "admin-lb" {
  value = "${outscale_public_ip.admin_lb.public_ip}"
}
