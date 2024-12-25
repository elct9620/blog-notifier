# frozen_string_literal: true

require 'bundler/setup'
require 'dry/system'

Bundler.require(:default)

# :nodoc:
class Application < Dry::System::Container
  use :env, inferrer: -> { ENV.fetch('APP_ENV', 'development') }
  use :zeitwerk

  configure do |config|
    config.root = Pathname.new(__dir__).join('..')
    config.provider_dirs = ['config/providers']

    config.component_dirs.add 'app'
    config.component_dirs.add 'lib' do |dir|
      dir.auto_register = false
    end
  end

  def self.call(event:, context:)
    name = config.inflector.underscore(context.function_name).delete_suffix('_function')
    self["functions.#{name}"].call(event: event, context: context)
  end
end

Deps = Application.injector
