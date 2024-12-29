# frozen_string_literal: true

require 'net/http'

module Functions
  # :nodoc:
  class Fetcher
    include Deps[
      feeds: 'repository.feed',
      queue: 'queues.notification'
    ]

    def call(event:, **)
      usecase = Usecase::ScheduleNotify.new(queue:, feeds:)
      out = usecase.call(uri: event['feed_uri'])
      out.map do |item|
        { title: item.title }
      end
    end
  end
end
