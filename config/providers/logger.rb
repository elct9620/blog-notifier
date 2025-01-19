# frozen_string_literal: true

Application.register_provider(:logger) do
  prepare do
    require 'dry/logger'
  end

  start do
    register(:logger, Dry::Logger(
                        Application.env,
                        formatter: :json
                      ))
  end
end
