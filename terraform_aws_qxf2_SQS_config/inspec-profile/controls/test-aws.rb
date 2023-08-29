
# verify AWS SQS Configuration
title "aws SQS config test"

Content = inspec.profile.file(“terraform.json”)
Params = JSON.parse(content)
sqs = params['queue_name'][value]

# you add controls here
control "aws-sqs-config" do                      
  impact 1.0                               
  title "verify aws sqs configuration"                                       
  describe aws_sqs(queue_url: attribute(sqs)) do
    it { should exist}
  end
end