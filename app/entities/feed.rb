# frozen_string_literal: true

module Entities
  # :nodoc:
  class Feed
    include Enumerable

    attr_reader :items

    def initialize
      @items = []
    end

    def add_item(item)
      @items << item
    end

    def each(&)
      @items.each(&)
    end
  end
end
