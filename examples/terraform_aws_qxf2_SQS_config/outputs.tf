# Stores SQS queue name 
output "queue_name" {
  description = "Name of the created SQS queue"
  value       = aws_sqs_queue.queue.id
}