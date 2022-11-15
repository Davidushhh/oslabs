provider "aws" {
    access_key = "AKIA5NR4ZWOLU7M555JV"
    secret_key = "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"
    region = "us-east-1"
}


resource "aws_instance" "webserver" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  key_name = "oslab"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data = <<E0F
#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
E0F
}

resource "aws_security_group" "webserver" {
  name        = "webserver_security_group"
  description = "sg"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["37.229.74.17/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  }

  resource "aws_key_pair" "deployer" {
    key_name = "oslab"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkttiW90DDpTXeM5d6ZqSJAYcv4sZnLx+Vf9QaBmvc2EGhqXeEHmBg2Uz3jqM/Ekd3ZCTTiB3eRyH6cky5f43TnNu0Yq1WNq4PH9M3QaOsobjyBXwG4qvltKbIKWO0GSckmPRwronzC+8Y6w76OXkpTfTRA6XXgxZZW+WgSgOZy6Xg7sGVdUS2Re/aXNzd+P8c7qei67CYm1VONdPoL61PO+6BXgRSTYe/klDUcZKbB1c/y1YTt6UXL6WtqN5hHe9MX6cVHqtboO1nQ6wWVAZgrkzMSIwB9KzKfwKsTKCJeKerQRdvHEN6eKoIo0oyTCzjtN+AocT3c1OV6vlWaoe3 davidushhh@davidushhh-B450M-DS3H"
  }
