Feature: Notifier
  Scenario: The notifier send the latest article to specific channel
    When the "NotifierFunction" is invoked with the following payload:
      """
      {
        "Records": [
          {
            "eventSource": "aws:sqs",
            "eventSourceARN": "arn:aws:sqs:ap-northeast-1:123456789012:blog_notifier-queue",
            "messageId": "c80e8021-a70a-42c7-a470-796e1186f753",
            "body": "{\"destination\":\"discord\",\"item\":{\"title\":\"可能性 - 重新思考 Rails 架構\"}}"
          }
        ]
      }
      """
    Then the lambda function response should be:
      """
      [
        {
          "destination": "discord",
          "item": {
            "title": "可能性 - 重新思考 Rails 架構"
          }
        }
      ]
      """
