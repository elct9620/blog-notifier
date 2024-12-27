# frozen_string_literal: true

module Usecase
  # :nodoc:
  class ScheduleNotify
    attr_reader :queue, :feeds

    def initialize(queue:, feeds:)
      @queue = queue
      @feeds = feeds
    end

    def call(uri:)
      feed = feeds.find(uri)

      feed.items.map do |item|
        entity = { title: item.title }
        queue.enqueue(entity)
        entity
      end
    end
  end
end
