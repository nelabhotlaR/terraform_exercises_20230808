title "Test to verify if the AWS EC2 instance is configured properly"

# Load the JSON data from terraform.json
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

instance_id = params['instance_id']['value']
public_dns = params['public_dns']['value']
public_ip = params['public_ip']['value']

control 'ec2_instance_configuration' do
  impact 0.7
  title 'EC2 Instance Configuration Test'
  desc 'Ensure the EC2 instance is properly configured'

  describe aws_ec2_instance(instance_id) do
    it { should be_running }
    its('public_dns_name') { should eq public_dns }
    its('public_ip_address') { should eq public_ip }
    its('image_id') { should eq 'ami-0f5ee92e2d63afc18' }
  end

  describe aws_ec2_instance(instance_id) do
    its('tags_hash') { should include('Name' => 'terraform-carsapi') }
  end
end

control 'ec2_security_group' do
  impact 0.7
  title 'EC2 Instance Security Group Test'
  desc 'Ensure the Security Group is properly created and configured'

  describe aws_security_group(group_name: 'tls_cars') do
    it { should exist }
    its('group_id') { should_not eq '' }
    its('vpc_id') { should_not eq '' }
  end

  describe aws_security_group(group_name: 'tls_cars') do
    its('inbound_rules_count') { should cmp 8 }
    it { should allow_in(port: 22, protocol: 'tcp', ipv4_range: '0.0.0.0/0', ipv6_range: '::/0') }
    it { should allow_in(port: 5000, protocol: 'tcp', ipv4_range: '0.0.0.0/0', ipv6_range: '::/0') }
    it { should allow_in(port: 443, protocol: 'tcp', ipv4_range: '0.0.0.0/0', ipv6_range: '::/0') }
    it { should allow_in(port: 80, protocol: 'tcp', ipv4_range: '0.0.0.0/0', ipv6_range: '::/0') }
  end

  describe aws_security_group(group_name: 'tls_cars') do
    it { should allow_out(port: 0, protocol: '-1', ipv4_range: '0.0.0.0/0', ipv6_range: '::/0') }
  end
end
  
control 'ec2_docker_check' do
  impact 0.7
  title 'EC2 Docker Test'
  desc 'Ensure Docker is properly installed and configured on EC2 instance'
  describe service('docker') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe docker.version do
    its('Server.Version') { should cmp >= '20.10'}
    its('Client.Version') { should cmp >= '20.10'}
  end
end
  
control 'ec2_docker_image_check' do
  impact 0.7
  title 'EC2 Docker Image Test'
  desc 'Ensure Docker Image is properly created and configured'
  describe docker_image('cars-api') do
    it { should exist }
    its('id') { should_not eq '' }
  end

  describe docker.images do
    its('ids') { should_not eq '' }
    its('repositories') { should include 'cars-api' }
    its('tags') { should include 'latest' }
  end
end

control 'ec2_docker_container_check' do
  impact 0.7
  title 'EC2 Docker Container Test'
  desc 'Ensure Docker Container is up and running'
  describe docker.containers do 
    its('images') { should include 'cars-api' }
  end
 
  describe docker_container(name: 'cars-api') do
    it { should exist }
    it { should be_running }
    its('id') { should_not eq '' }
    its('image') { should eq 'cars-api' }
    its('ports') { should include '0.0.0.0:5000->5000/tcp' }
    its('command') { should eq 'python cars_app.py' }
  end
end

control 'ec2_cars_app_check' do
  impact 0.7
  title 'EC2 Cars App Test'
  desc 'Ensure the Cars API app is up and running'
  describe http('http://localhost:5000/cars', 
           auth: {user:'qxf2', pass: 'qxf2'},
           method: 'GET') do
    its('status') { should cmp 200 }
    its('body') { should include '"successful":true' }
  end
end