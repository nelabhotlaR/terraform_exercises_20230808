# Create an EC2 instance
resource "aws_instance" "training_wedsite_instance" {
  ami           = "ami-0261755bbcb8c4a84" # AMI ID
  instance_type = var.training_website_ec2_inst_type
  #key_name      = var.training_website_key_pair  #key pair name
  key_name = "${aws_key_pair.training_web_site.id}"
  vpc_security_group_ids = [aws_security_group.training_website_sg.id]
    tags = {
        "Name"  : "training_website-EC2instance"
    }
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.training_wedsite_instance.public_ip
      user        = "ubuntu"
      private_key = file(var.private_key_path)
    }
    inline = [ 
     # training website deployment
      "echo starting setup for the app",
      "sudo apt-get install -y git",
      "sleep 2m",
      "git clone https://github.com/qxf2/training-website.git",
      "cd ~/training-website",
      "echo Creating a new virtual enviroment",
      "virtualenv venv-tsqa",
      "sleep 2s",
      "echo Activate your virtual environment", 
      ". venv-tsqa/bin/activate",
      "sleep 2s",
      "echo Installing the requirements",
      "pip install -r requirements.txt",
      "echo Installing the gunicorn",
      "pip install gunicorn",
      "sleep 2s",
      "echo Running the app",
      "gunicorn -w 4 -b 0.0.0.0:6464 tsqa:app &",
      "echo App deployed successfully",
      "sleep 10s"
    ]
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y python3-virtualenv
              sudo apt-get install -y python3-pip
              EOF
}

resource "aws_key_pair" "training_web_site" {
  key_name = "trainingwebsite"
  public_key = file(var.public_key_path)
}