# frozen_string_literal: true

require_relative 'app'

# :nodoc:
module Lambda
  # :nodoc:
  class Handler
    attr_reader :event, :context

    def initialize(event:, context:)
      @event = event
      @context = context
    end

    def call
      Application["functions.#{name}"].call(event: event, context: context)
    end

    private

    def name
      @name ||= Application.config.inflector.underscore(context.function_name).delete_suffix('_function')
    end
  end

  module_function

  def call(event:, context:)
    Application.finalize!

    Handler.new(event: event, context: context).call
  end
end
