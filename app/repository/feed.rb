# frozen_string_literal: true

require 'date'

module Repository
  # :nodoc:
  class Feed
    def find(uri)
      entity = Entities::Feed.new

      body = Net::HTTP.get(URI(uri))
      RSS::Parser.parse(body).items.each do |item|
        entity.add_item(build_feed_item(item))
      end

      entity
    end

    private

    def build_feed_item(item)
      Entities::FeedItem.new(
        title: item.title,
        link: item.link,
        published_at: DateTime.parse(item.pubDate.to_s)
      )
    end
  end
end
