# frozen_string_literal: true

module Usecase
  # :nodoc:
  class ScheduleNotify
    attr_reader :queue, :feeds, :channels, :settings

    def initialize(queue:, feeds:, channels:, settings:)
      @queue = queue
      @feeds = feeds
      @channels = channels
      @settings = settings
    end

    def call(uri:, scheduled_at:)
      feed = feeds.find(uri, start_at: scheduled_at - settings.notify_period)

      channels.all.flat_map do |channel|
        {
          channel: channel.type,
          items: feed.select do |item|
            queue.enqueue(destination: channel.type, item: item)
          end
        }
      end
    end
  end
end
