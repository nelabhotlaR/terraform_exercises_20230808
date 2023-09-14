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
  connection {
    host=aws_instance.training_wedsite_instance.public_ip
    user = "ubuntu"
    agent = false
  }
  provisioner "remote-exec" {
    /*connection {
      host        = aws_instance.training_wedsite_instance.public_ip
      user        = "ubuntu"
      private_key = file(var.private_key_path)
    }*/
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDUSUF81KiZvtzyqcNQZiOLx+v3ZUQ/jbYpTGplxtYViIsFuQwm0ovHTtTicYznrvcudZx6q+M0NS9R90HMXnfRFoZMtENaLPsn7cFEdR5vqvjjUe/rEOYX0wkyT+LronugKySze6U7JZDh1X/BMEC0tX/+y3308DXRkJ2t1KHYHdjZiIKLOqhxELWyV8n9MyA00lyB2FH5Yr62E9W1Hi7/SzRgcA8/bzJDehcs8i7XZNrvJ7A8h/NTtPw5ldQqbjqFpOqiUXsRaHTGEYhyMuLCB3MSDZO4rpc/ZePQQHj83DQ0dhCGWB27RGTs29oizElFyAu8MtO+RxHh67FUtGvoED2FiuW4VNKXAqmP2T2CpZmKPDZHn6EN1kKEDpwxO+TsL9xiCzztW+HTikD16eMLTdaSduF2vvvu279DrWkIWC1e7ocYUURS0FGFuIP82TmNfB0H7a/NnsheEBtQOVIuObSSuRep1L0bB/W5G0vfDPdhcrg4jYSrOKmDiYJVFWKaAZSN8fKRRzn9o9H632XD5eOv6bn2YKGvT1++Jl+XAyF9XQ4Z0ii7rsiIUxKKLrAAVViUV8k3Zo5/1P7HeynCvh/idPE6JcIIcAGq9Ik53mnk1thXsxXuU8XY6b9GMzyGhbKY0WHmi3lx0zkdDSIfJeiqSuV1MQwZh7CDiD6R4w== nelbo@nelbo-Lenovo-IdeaPad-S145-15IWL"
}