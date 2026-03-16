@sdk @sqs_helper
Feature: SQS test helper

  @happy
  Scenario: Send a message and receive it back
    Given a running session with an SQS queue "OrderQueue"
    When I send message body "order-sqs-001" to "OrderQueue"
    Then receiving 1 message from "OrderQueue" returns body "order-sqs-001"

  @happy
  Scenario: Receive respects the requested max message count
    Given a running session with an SQS queue "OrderQueue"
    And I send message body "msg-1" to "OrderQueue"
    And I send message body "msg-2" to "OrderQueue"
    When I receive 1 message from "OrderQueue"
    Then exactly 1 message is returned
