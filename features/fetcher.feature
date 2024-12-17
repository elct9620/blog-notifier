Feature: Fetcher
  Scenario: The fetcher get latest articles from the feed
    Given the feed "https://blog.aotoki.me/index.xml" has content in the path "feed.xml"
    When the "FetcherFunction" is invoked with the following payload:
      """
      {
        "feed_uri": "https://blog.aotoki.me/index.xml"
      }
      """
    Then the lambda function response should be:
      """
      [
        {
          "title": "可能性 - 重新思考 Rails 架構"
        },
        {
          "title": "Query - 重新思考 Rails 架構"
        },
        {
          "title": "從 Clean Architecture 反思抽象化"
        },
        {
          "title": "Output - 重新思考 Rails 架構"
        },
        {
          "title": "Repository - 重新思考 Rails 架構"
        },
        {
          "title": "Entity - 重新思考 Rails 架構"
        },
        {
          "title": "Use Case - 重新思考 Rails 架構"
        },
        {
          "title": "Form - 重新思考 Rails 架構"
        },
        {
          "title": "Controller - 重新思考 Rails 架構"
        },
        {
          "title": "驗收測試 - 重新思考 Rails 架構"
        }
      ]
      """
