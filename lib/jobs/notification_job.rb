# frozen_string_literal: true

module Jobs
  # :nodoc:
  class NotificationJob
    include Deps[:sqs]

    def enqueue(feed)
      sqs.send_message(
        queue_url: ENV.fetch('QUEUE_URL', nil),
        message_body: feed.to_json
      )
    end
  end
end
