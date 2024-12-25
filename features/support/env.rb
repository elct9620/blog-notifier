# frozen_string_literal: true

require 'webmock/cucumber'
require 'rspec'

ENV['APP_ENV'] = 'test'
ENV['QUEUE_URL'] = 'https://sqs.ap-northeast-1.amazonaws.com/123456789012/blog-notifier_queue'

require_relative '../../config/app'
require_relative '../../config/lambda'
