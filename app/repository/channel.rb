# frozen_string_literal: true

module Repository
  # :nodoc:
  class Channel
    CONFIG_NAME = 'channels'

    include Deps[
      :appconfig
    ]

    def all
      appconfig.get(CONFIG_NAME).map do |config|
        Entities::Channel.new(
          type: config[:type],
          options: {
            channel: config[:channel]
          }
        )
      end
    end
  end
end
