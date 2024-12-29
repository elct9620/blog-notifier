# frozen_string_literal: true

module Entities
  # :nodoc:
  class FeedItem
    attr_reader :title, :link, :published_at

    def initialize(title:, link:, published_at:)
      @title = title
      @link = link
      @published_at = published_at
    end
  end
end
