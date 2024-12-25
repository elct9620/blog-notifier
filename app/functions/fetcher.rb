# frozen_string_literal: true

require 'net/http'

module Functions
  # :nodoc:
  class Fetcher
    def call(event:, **)
      uri = URI(event['feed_uri'])
      body = Net::HTTP.get(uri)
      feed = RSS::Parser.parse(body)

      queue = Jobs::NotificationJob.new
      usecase = Usecase::ScheduleNotify.new(queue:)
      usecase.call(feed)
    end
  end
end
