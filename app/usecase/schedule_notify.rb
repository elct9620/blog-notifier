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

      feed.each do |item|
        channels.all.each do |channel|
          queue.enqueue(
            destination: channel.type,
            item: item.to_h
          )
        end
      end
    end
  end
end
