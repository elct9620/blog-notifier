# frozen_string_literal: true

module Usecase
  # :nodoc:
  class ScheduleNotify
    ONE_DAY = 1

    attr_reader :queue, :feeds

    def initialize(queue:, feeds:)
      @queue = queue
      @feeds = feeds
    end

    def call(uri:, scheduled_at:)
      feed = feeds.find(uri, start_at: scheduled_at - ONE_DAY)

      feed.each do |item|
        queue.enqueue(item)
      end
    end
  end
end
