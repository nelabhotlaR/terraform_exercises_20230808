
title "Validate SES Configuration"

content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

ses_domain_identity_arn = params['ses_arn']['value']
ses_rule_set_name = params['aws_ses_receipt_rule_set_name']['value']

# you add controls here
control "SES Config" do    
  title "Check for SES"           
  desc "validate the SES Configuration created using terraform matches"
  describe aws_ses_receipt_rule_set(rule_set_name: "#{ses_rule_set_name}" ) do
    it { should exist }
  end
  describe aws_ses_receipt_rule_set(rule_set_name: "#{ses_rule_set_name}" ) do
    its('scan_enabled') { should eq false }
  end
end
