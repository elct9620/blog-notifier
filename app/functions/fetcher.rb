# frozen_string_literal: true

require 'net/http'

module Functions
  # :nodoc:
  class Fetcher
    def call(event:, **)
      uri = URI(event['feed_uri'])
      body = Net::HTTP.get(uri)
      feed = RSS::Parser.parse(body)

      usecase = Usecase::ScheduleNotify.new
      usecase.call(feed)
    end
  end
end
