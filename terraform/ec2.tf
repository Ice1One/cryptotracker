resource "aws_instance" "taskmanager_ec2" {
  ami                         = "ami-0faab6bdbac9486fb"
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet_1
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name                    = "taskmanager-key"

  user_data = <<-EOF
    #!/bin/bash
    apt update
    apt install -y docker.io
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ubuntu
    docker pull ${var.docker_image}
    docker run -d -p 8000:8000 \
      --name taskmanager \
      -e DATABASE_URL="${var.database_url}" \
      ${var.docker_image}
  EOF

  tags = {
    Name = "taskmanager-ec2"
  }
}
