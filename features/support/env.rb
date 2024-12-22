# frozen_string_literal: true

require 'webmock/cucumber'
require 'rspec'

require_relative '../../config/app'
require_relative '../../config/lambda'

Before do
  # Stub the AWS metadata service to return a token
  stub_request(:put, 'http://169.254.169.254/latest/api/token')
    .to_return(status: 200, body: '', headers: {})

  # Stub the AWS metadata service to return an empty response
  stub_request(:get, 'http://169.254.169.254/latest/meta-data/iam/security-credentials/')
    .to_return(status: 200, body: '', headers: {})
end
