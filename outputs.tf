output "vm_ip_a" {
  description = "Public IP of Public VM a."
  value       = azurerm_public_ip.vm_ip_a.ip_address
}

output "vm_ip_b" {
  description = "Public IP of VM b."
  value = azurerm_public_ip.vm_ip_b.ip_address
}