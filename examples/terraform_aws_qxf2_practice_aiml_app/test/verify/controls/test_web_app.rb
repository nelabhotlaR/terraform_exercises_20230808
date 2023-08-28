content = inspec.profile.file("terraform_output.json")
params = JSON.parse(content)
instance_ip = params["instance_public_ip"]["value"]

describe http("http://#{instance_ip}") do
  its('status') { should cmp 200 }
end