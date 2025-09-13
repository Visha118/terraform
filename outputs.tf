output "instance_public_ip" {
  value = aws_instance.my_first_instance.public_ip
}

output "private_key_path" {
  value = local_file.private_key_pem.filename
}