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

      feed.each do |item|
        queue.enqueue(item)
      end
    end
  end
end
