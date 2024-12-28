# frozen_string_literal: true

module Entities
  # :nodoc:
  class Feed
    attr_reader :items

    def initialize
      @items = []
    end

    def add_item(item)
      @items << item
    end
  end
end
