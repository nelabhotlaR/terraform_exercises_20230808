# Create a security group
resource "aws_security_group" "training_website_sg" {
  name        = "training-website-sg"
  description = "Security group for Training Website EC2 instance"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6464
    to_port     = 6464
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Add any additional ingress rules as needed

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name = "training_website-EC2instance"
  }

}