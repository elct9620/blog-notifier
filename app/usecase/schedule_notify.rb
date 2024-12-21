# frozen_string_literal: true

module Usecase
  # :nodoc:
  class ScheduleNotify
    def call(feed)
      feed.items.map do |item|
        {
          title: item.title
        }
      end
    end
  end
end
