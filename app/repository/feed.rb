# frozen_string_literal: true

module Repository
  # :nodoc:
  class Feed
    def find(uri)
      body = Net::HTTP.get(URI(uri))
      RSS::Parser.parse(body)
    end
  end
end
