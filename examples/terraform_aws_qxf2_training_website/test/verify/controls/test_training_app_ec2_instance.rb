# Test to verify Qxf2 training app instance is exist and running 
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)
ec2_instance_id = params['instance_id']['value']
ec2_instance_public_ip= params['instance_publicip']['value']
ec2_instance_public_dns = params['instance_publicdns']['value']

describe aws_ec2_instance(ec2_instance_id) do
    it { should exist }
    it { should be_running }
    its('public_ip_address') { should_not be_nil }
    its('public_dns_name') { should_not be_nil }
    its('public_ip_address') { should eq ec2_instance_public_ip }
    its('public_dns_name') { should eq ec2_instance_public_dns }
  end
