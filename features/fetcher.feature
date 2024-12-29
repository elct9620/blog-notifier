Feature: Fetcher
  Scenario: The fetcher get latest articles from the feed
    Given the feed "https://blog.aotoki.me/index.xml" has content in the path "feed.xml"
    When the "FetcherFunction" is invoked with the following payload:
      """
      {
        "feed_uri": "https://blog.aotoki.me/index.xml",
        "scheduled_at": "2024-12-06T00:00:00+08:00"
      }
      """
    Then the lambda function response should be:
      """
      [
        {
          "title": "可能性 - 重新思考 Rails 架構"
        }
      ]
      """
