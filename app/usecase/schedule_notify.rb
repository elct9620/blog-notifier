# frozen_string_literal: true

module Usecase
  # :nodoc:
  class ScheduleNotify
    attr_reader :queue

    def initialize(queue:)
      @queue = queue
    end

    def call(feed)
      feed.items.map do |item|
        entity = { title: item.title }
        queue.enqueue(entity)
        entity
      end
    end
  end
end
