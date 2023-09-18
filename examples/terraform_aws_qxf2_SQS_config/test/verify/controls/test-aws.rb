# verify AWS SQS Configuration
title "aws SQS config test"

# Load the content of terraform.json
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

# Retrieve the queue_name value
queue_url = params["queue_name"]["value"]

# you add controls here
control "aws-sqs-config" do                      
  impact 1.0                               
  title "verify aws sqs configuration"                                       
  describe aws_sqs_queue(queue_url) do
    it { should exist }
  end
end
