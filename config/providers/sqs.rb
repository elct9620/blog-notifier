# frozen_string_literal: true

Application.register_provider(:sqs) do
  prepare do
    require 'aws-sdk-sqs'
  end

  start do
    register(:sqs, Aws::SQS::Client.new(
                     stub_responses: Application.env == 'test'
                   ))
  end
end
