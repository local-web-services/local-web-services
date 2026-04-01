@sqs @sqs_helper @dataplane
Feature: SQS helper sends and receives messages

  @happy @minimal
  Scenario: Send a message and receive it back
    Given an SQS queue named "OrderQueue"
    When I send message body "order-sqs-001" to "OrderQueue"
    Then receiving 1 message from "OrderQueue" will return body "order-sqs-001"
