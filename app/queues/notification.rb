# frozen_string_literal: true

module Queues
  # :nodoc:
  class Notification
    include Deps[
      :sqs,
      :logger
    ]

    def enqueue(destination:, item:)
      logger.info("Enqueuing item #{item.title} to #{destination}")
      sqs.send_message(
        queue_url: ENV.fetch('QUEUE_URL', nil),
        message_body: build_message(destination:, item:).to_json
      )
    end

    private

    def build_message(destination:, item:)
      {
        destination: destination,
        item: {
          title: item.title,
          link: item.link
        }
      }
    end
  end
end
