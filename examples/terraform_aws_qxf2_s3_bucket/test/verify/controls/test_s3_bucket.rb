title "Tests to verify the S3 bucket configuration, created using Terraform"

# Read the Terraform JSON ouput into variables
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)
BUCKET_NAME = params['s3_bucket_id']['value']
BUCKET_REGION = params['s3_bucket_region']['value']

control "Verify-S3-bucket" do
  impact 1.0
  title "Tests to verify configuration of S3 bucket"
  describe aws_s3_bucket(bucket_name: BUCKET_NAME) do
    it { should exist }
    its('region') { should eq BUCKET_REGION }
  end
  describe aws_s3_bucket_objects(bucket_name: BUCKET_NAME) do
    it { should exist }
    its('key_counts') { should include 2 }
  end
end


