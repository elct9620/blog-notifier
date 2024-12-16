# frozen_string_literal: true

# :nodoc:
class Lambda
  def self.call(*)
    { ok: gem('rss') }
  end
end
