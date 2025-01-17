# frozen_string_literal: true

module Entities
  # :nodoc:
  class Channel
    attr_reader :type, :options

    def initialize(type:, options: {})
      @type = type
      @options = options
    end
  end
end
