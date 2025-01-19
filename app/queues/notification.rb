# frozen_string_literal: true

module Queues
  # :nodoc:
  class Notification
    include Deps[:sqs]

    def enqueue(destination:, item:)
      sqs.send_message(
        queue_url: ENV.fetch('QUEUE_URL', nil),
        message_body: {
          destination: destination,
          item: {
            title: item.title,
            link: item.link
          }
        }.to_json
      )
    end
  end
end
