output "jump_box_public_ip" {
  description = "Public IP of the Jump Box"
  value       = aws_instance.jump_box.public_ip
}

output "apache_server_private_ip" {
  description = "Private IP of the Apache Server"
  value       = aws_instance.apache_server.private_ip
}
