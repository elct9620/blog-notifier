# frozen_string_literal: true

module Repository
  # :nodoc:
  class Feed
    def find(uri)
      entity = Entities::Feed.new

      body = Net::HTTP.get(URI(uri))
      RSS::Parser.parse(body).items.each do |item|
        entity.add_item({
                          title: item.title
                        })
      end

      entity
    end
  end
end
