# frozen_string_literal: true

module Usecase
  # :nodoc:
  class ScheduleNotify
    attr_reader :queue, :feeds, :settings

    def initialize(queue:, feeds:, settings:)
      @queue = queue
      @feeds = feeds
      @settings = settings
    end

    def call(uri:, scheduled_at:)
      feed = feeds.find(uri, start_at: scheduled_at - settings.notify_period)

      feed.each do |item|
        queue.enqueue(
          destination: :discord,
          item: item.to_h
        )
      end
    end
  end
end
