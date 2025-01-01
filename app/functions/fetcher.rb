# frozen_string_literal: true

require 'net/http'

module Functions
  # :nodoc:
  class Fetcher
    include Deps[
      :settings,
      feeds: 'repository.feed',
      queue: 'queues.notification'
    ]

    def call(event:, **)
      scheduled_at = DateTime.parse(event['scheduled_at'])

      usecase = Usecase::ScheduleNotify.new(queue:, feeds:, settings:)
      out = usecase.call(uri: event['feed_uri'], scheduled_at:)
      out.map do |item|
        { title: item.title }
      end
    end
  end
end
