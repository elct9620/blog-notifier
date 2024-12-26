# frozen_string_literal: true

module Functions
  # :nodoc:
  class Notifier
    def call(event:, **)
      usecase = Usecase::SendNotify.new
      event['Records'].map do |record|
        body = JSON.parse(record['body'])

        usecase.call(
          destination: body['destination'],
          item: body['item']
        )
      rescue JSON::ParserError => e
        { error: e.message }
      end
    end
  end
end
