output "public_ip_address" {
  value = "The servers public IP: ${azurerm_public_ip.pip.ip_address}"
}