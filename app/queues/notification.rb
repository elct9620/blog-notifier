# frozen_string_literal: true

module Queues
  # :nodoc:
  class Notification
    include Deps[:sqs]

    def enqueue(payload)
      sqs.send_message(
        queue_url: ENV.fetch('QUEUE_URL', nil),
        message_body: payload.to_json
      )
    end
  end
end
