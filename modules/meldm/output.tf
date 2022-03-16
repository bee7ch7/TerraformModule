output "ip_meldm" {
    value = aws_instance.web.public_ip
  }

output "dns_meldm" {
    value = aws_instance.web.public_dns
  }
