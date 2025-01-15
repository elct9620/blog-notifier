# frozen_string_literal: true

Application.register_provider(:appconfig) do
  start do
    register(:appconfig, AppConfig::Client.new(
                           app_name: ENV.fetch('NAMESPACE', 'blog-notifier'),
                           env: ENV.fetch('APP_ENV', 'production')
                         ))
  end
end
