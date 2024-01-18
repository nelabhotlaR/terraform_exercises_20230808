provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg_2"
  description = "Allow incoming HTTP traffic"
  
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_instance" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t3.micro"
  key_name      = "KEY_NAME"  # Replace with your actual key pair name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get -y update

              [Install]
              WantedBy=multi-user.target
              EOF_SERVICE
              sudo chmod 777 /home/ubuntu
              sudo apt-get -y install nginx

              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF



  tags = {
    Name = "web_instance"
  }
}

output "public_ip" {
  value = aws_instance.web_instance.public_ip
}

output "dns" {
  value = aws_instance.web_instance.public_dns
}

output "instance_id" {
  value = aws_instance.web_instance.id
}

output "instance_type" {
  value = aws_instance.web_instance.instance_type
}
