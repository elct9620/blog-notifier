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
      usecase.call(uri: event['feed_uri'])
    end
  end
end
