# frozen_string_literal: true

module Usecase
  # :nodoc:
  class SendNotify
    def call(destination:, item:)
      {
        destination:,
        item: {
          title: item[:title]
        }
      }
    end
  end
end
