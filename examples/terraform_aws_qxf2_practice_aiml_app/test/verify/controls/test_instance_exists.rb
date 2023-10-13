content = inspec.profile.file("terraform_output.json")
params = JSON.parse(content)
instance_id = params["instance_id"]["value"]

describe aws_ec2_instance(instance_id) do
  it { should exist }
end