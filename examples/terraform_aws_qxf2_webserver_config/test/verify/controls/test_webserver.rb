title "Tests to verify the nginx configuration, created using Terraform"

# Read the Terraform JSON ouput into variables
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)
instance_ip = params["public_ip"]["value"]
instance_id = params["instance_id"]["value"]


control "Verify-webserver" do
  impact 1.0
  title "Tests to verify configuration nginx webserver"
  # Check public IP of an EC2 instance
  describe aws_ec2_instance(instance_id) do
    it { should exist }
  end

  # Verify the status of the EC2 instance
  describe aws_ec2_instance(instance_id) do
    its('state') { should eq 'running' }
  end

  # Verify the availability zone of the EC2 instance
  describe aws_ec2_instance(instance_id) do
    its('availability_zone') { should eq 'ap-south-1a' } 
  end

  # Verify the webservice package is installed
  describe package('nginx') do
    it { should be_installed }
  end
end

