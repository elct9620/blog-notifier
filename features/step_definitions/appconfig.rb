# frozen_string_literal: true

Given('the appconfig profile {string} has following configuration') do |name, config|
  stub_request(
    :get,
    "http://localhost:2772/applications/blog-notifier/environments/test/configurations/#{name}"
  ).to_return(status: 200, body: config, headers: {})
end
