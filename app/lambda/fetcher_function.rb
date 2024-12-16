# frozen_string_literal: true

# :nodoc:
class FetcherFunction
  def call(*)
    { ok: gem('rss') }
  end
end
