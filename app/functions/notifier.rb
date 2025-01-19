# frozen_string_literal: true

module Functions
  # :nodoc:
  class Notifier
    include Deps[
      :logger,
    ]

    def call(event:, **) # rubocop:disable Metrics/MethodLength
      usecase = Usecase::SendNotify.new
      event['Records'].map do |record|
        body = JSON.parse(record['body'], symbolize_names: true)
        logger.info("Sending notification to #{body[:destination]} for #{body.dig(:item, :title)}")

        usecase.call(
          destination: body[:destination],
          item: body[:item]
        )
      rescue JSON::ParserError => e
        { error: e.message }
      end
    end
  end
end
