# frozen_string_literal: true

require 'net/http'

module Functions
  # :nodoc:
  class Fetcher
    include Deps[
      :settings,
      :logger,
      feeds: 'repository.feed',
      channels: 'repository.channel',
      queue: 'queues.notification'
    ]

    def call(event:, **)
      logger.info("Fetching feed #{event['feed_uri']}")
      scheduled_at = DateTime.parse(event['scheduled_at'])

      usecase = Usecase::ScheduleNotify.new(queue:, channels:, feeds:, settings:)
      out = usecase.call(uri: event['feed_uri'], scheduled_at:)
      out.map do |item|
        {
          channel: item[:channel],
          items: item[:items].map(&:title)
        }
      end
    end
  end
end
