# frozen_string_literal: true

require 'dry/system'
require 'dry/system/provider_sources'

Application.register_provider(:settings, from: :dry_system) do
  settings do
    setting :notify_period, default: ENV.fetch('NOTIFY_PERIOD', 1), constructor: proc(&:to_i)
  end
end
