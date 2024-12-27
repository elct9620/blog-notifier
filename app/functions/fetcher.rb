# frozen_string_literal: true

require 'net/http'

module Functions
  # :nodoc:
  class Fetcher
    def call(event:, **)
      queue = Jobs::NotificationJob.new
      feeds = Repository::Feed.new
      usecase = Usecase::ScheduleNotify.new(queue:, feeds:)
      usecase.call(uri: event['feed_uri'])
    end
  end
end
