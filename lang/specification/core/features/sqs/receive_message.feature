@sqs @receive_message @dataplane
Feature: SQS ReceiveMessage

  @happy
  Scenario: Receive a message from a queue
    Given a queue "e2e-recv-msg" was created
    And a message "test-body" was sent to queue "e2e-recv-msg"
    When I receive a message from queue "e2e-recv-msg"
    Then the command will succeed
    And the output will contain a message with body "test-body"
