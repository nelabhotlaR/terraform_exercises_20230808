provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "aiml_security_group" {
  name_prefix = "aiml-security-group-"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
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

resource "aws_instance" "aiml_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.micro"
  key_name      = "temporary_key"
  security_groups = [aws_security_group.aiml_security_group.name]
  user_data = <<-EOF
              #!/bin/bash
              mkdir /home/ubuntu/code
              cd /home/ubuntu/code
              git clone https://github.com/qxf2/practice-testing-ai-ml
              sudo chmod 777 practice-testing-ai-ml
              cd practice-testing-ai-ml
              sudo apt-get -y update
              sudo apt-get -y install python3-pip
              yes|sudo apt-get -y install python3-virtualenv
              virtualenv venv
              source venv/bin/activate
              export  SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True
              pip install -r requirements.txt
              pip install uwsgi

              cat << EOF_SERVICE > /etc/systemd/system/aiml.service
              [Unit]
              Description=UWSGI instance for the practice-testing-ai-ml project
              After=network.target
              StartLimitIntervalSec=0

              [Service]
              Restart=always
              RestartSec=1
              User=ubuntu
              Group=www-data
              WorkingDirectory=/home/ubuntu/code/practice-testing-ai-ml
              Environment="PATH=/home/ubuntu/code/practice-testing-ai-ml/venv/bin"
              ExecStart=/home/ubuntu/code/practice-testing-ai-ml/venv/bin/uwsgi --ini aiml.ini

              [Install]
              WantedBy=multi-user.target
              EOF_SERVICE
              sudo chmod 777 /home/ubuntu
              systemctl enable aiml.service
              systemctl start aiml.service
              sudo apt-get -y install nginx

              # Configure NGINX to serve the uWSGI app
              cat << EOF_NGINX > /etc/nginx/sites-available/aiml
              server {
                  listen 80;
                  server_name _;

                  location / {
                      include uwsgi_params;
                      uwsgi_pass unix:///home/ubuntu/code/practice-testing-ai-ml/aiml.sock;
                  }
              }
              EOF_NGINX

              sudo ln -s /etc/nginx/sites-available/aiml /etc/nginx/sites-enabled
              sudo rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
              sudo nginx -t  # Check NGINX configuration
              sudo systemctl reload nginx  # Restart NGINX
              EOF
              
  tags = {
    Name = "PracticeTestingAIML"
  }
}