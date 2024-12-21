# frozen_string_literal: true

require 'net/http'

module Functions
  # :nodoc:
  class Fetcher
    def call(event:, **)
      uri = URI(event['feed_uri'])
      body = Net::HTTP.get(uri)
      feed = RSS::Parser.parse(body)

      feed.items.map do |item|
        {
          title: item.title
        }
      end
    end
  end
end
