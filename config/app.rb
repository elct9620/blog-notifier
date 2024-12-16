# frozen_string_literal: true

require 'bundler/setup'
require 'dry/system'

Bundler.require(:default)

# :nodoc:
class Lambda < Dry::System::Container
  configure do |config|
    config.root = Bundler.root.join('app')

    config.component_dirs.add 'lambda'
  end

  def self.call(event:, context:)
    name = config.inflector.underscore(context.function_name)
    self[name].call(event: event, context: context)
  end
end

Lambda.finalize!
Deps = Lambda.injector
