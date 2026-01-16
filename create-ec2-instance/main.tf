//create ec2 instance
resource "aws_instance" "this" {
  ami                         = "ami-02b8269d5e85954ef" #ubuntu amazon machine image
  instance_type               = "t2.large"
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.this.id]
  # user_data                   = <<-EOF
  # #!/bin/bash
  # mkdir /home/ubuntu/test_dir
  # EOF
  user_data = templatefile("${path.module}/scripts/ec2_init.sh", {})

  tags = {
    Name = "devops-demo"
  }
}

//creating key pair to connect to ec2 instance
resource "aws_key_pair" "this" {
  key_name   = "devops-demo-key-pair"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  filename        = "${path.module}/devops-demo-private-key.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0400"
}

//creating a security group and mapping it with ec2 instance - to allow to connect(ssh) to ec2 instance from anywhere in the world
resource "aws_security_group" "this" {
  name        = "devops-demo-sg"
  description = "Allow ssh from anywhere"

  ingress {
    description = "ssh from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-demo-sg"
  }

}
