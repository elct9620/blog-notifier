Feature: Fetcher
  Scenario: The fetcher get latest articles from the feed
    Given the feed "https://blog.aotoki.me/index.xml" has content in the path "feed.xml"
    And the appconfig profile "channels" has following configuration
    """
    [
      {
        "type": "discord",
        "channel": "https://discord.com/api/webhooks/1234567890/ABCDEFGHIJKLMN0123456789"
      }
    ]
    """
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
          "channel": "discord",
          "items": ["可能性 - 重新思考 Rails 架構"]
        }
      ]
      """
