title "inspec test for lambda creation"

content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

lambda_function_name = params['function_name']['value']

control 'Lambda configuration' do
    title 'Lambda creation test'
    desc 'Ensure Lambda function is created'
    describe aws_lambda(lambda_function_name) do
        it { should exist }
        its ('handler') { should eq "#{lambda_function_name}.lambda_handler"}
        its ('runtime') { should eq 'python3.8' }
    end
end

