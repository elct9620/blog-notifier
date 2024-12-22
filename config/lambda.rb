# frozen_string_literal: true

require 'forwardable'

require_relative 'app'

# :nodoc:
module Lambda
  # :nodoc:
  class Handler
    FUNCTION_RESOLVE_KEY = 'functions'

    extend Forwardable
    delegate %w[config resolve] => Application
    delegate %w[inflector] => :config

    attr_reader :event, :context

    def initialize(event:, context:)
      @event = event
      @context = context
    end

    def call
      resolve("#{FUNCTION_RESOLVE_KEY}.#{name}").call(event: event, context: context)
    end

    private

    def namespace
      ENV.fetch('NAMESPACE', '')
    end

    def function_name
      ENV.fetch('AWS_LAMBDA_FUNCTION_NAME', context.function_name).delete_prefix("#{namespace}_")
    end

    def name
      @name ||= inflector.underscore(function_name).delete_suffix('_function')
    end
  end

  module_function

  def call(event:, context:)
    Application.finalize!

    Handler.new(event: event, context: context).call
  end
end
