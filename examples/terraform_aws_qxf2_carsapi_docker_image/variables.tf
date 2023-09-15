variable "aws_region" {
  description = "AWS region where the EC2 instance should be created"
  type        = string
  default     = "us-east-1"
}

/* variable "profile_name" {

} */

variable "ssh_public_key" {
  type        = string
  description = "The path of the SSH public key file"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDUSUF81KiZvtzyqcNQZiOLx+v3ZUQ/jbYpTGplxtYViIsFuQwm0ovHTtTicYznrvcudZx6q+M0NS9R90HMXnfRFoZMtENaLPsn7cFEdR5vqvjjUe/rEOYX0wkyT+LronugKySze6U7JZDh1X/BMEC0tX/+y3308DXRkJ2t1KHYHdjZiIKLOqhxELWyV8n9MyA00lyB2FH5Yr62E9W1Hi7/SzRgcA8/bzJDehcs8i7XZNrvJ7A8h/NTtPw5ldQqbjqFpOqiUXsRaHTGEYhyMuLCB3MSDZO4rpc/ZePQQHj83DQ0dhCGWB27RGTs29oizElFyAu8MtO+RxHh67FUtGvoED2FiuW4VNKXAqmP2T2CpZmKPDZHn6EN1kKEDpwxO+TsL9xiCzztW+HTikD16eMLTdaSduF2vvvu279DrWkIWC1e7ocYUURS0FGFuIP82TmNfB0H7a/NnsheEBtQOVIuObSSuRep1L0bB/W5G0vfDPdhcrg4jYSrOKmDiYJVFWKaAZSN8fKRRzn9o9H632XD5eOv6bn2YKGvT1++Jl+XAyF9XQ4Z0ii7rsiIUxKKLrAAVViUV8k3Zo5/1P7HeynCvh/idPE6JcIIcAGq9Ik53mnk1thXsxXuU8XY6b9GMzyGhbKY0WHmi3lx0zkdDSIfJeiqSuV1MQwZh7CDiD6R4w== nelbo@nelbo-Lenovo-IdeaPad-S145-15IWL"
}