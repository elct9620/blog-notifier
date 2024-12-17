# frozen_string_literal: true

LambdaContext = Data.define(:function_name)

Given('the feed {string} has content in the path {string}') do |uri, path|
  path = Pathname.new(__dir__).join('..', 'fixtures', path)
  stub_request(:get, uri).to_return(body: path.read)
end

When('the {string} is invoked with the following payload:') do |function_name, payload|
  @response = Lambda.call(
    event: JSON.parse(payload),
    context: LambdaContext.new(function_name: function_name)
  )
end

Then('the lambda function response should be:') do |payload|
  expect(@response).to eq(JSON.parse(payload, symbolize_names: true))
end
