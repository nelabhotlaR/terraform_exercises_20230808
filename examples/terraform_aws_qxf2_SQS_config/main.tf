# Create sqs queue
resource "aws_sqs_queue" "queue" {
  name = var.queue_name
}