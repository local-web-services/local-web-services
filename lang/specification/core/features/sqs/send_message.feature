@sqs @send_message @dataplane
Feature: SQS SendMessage

  @happy
  Scenario: Send a message to a queue
    Given a queue "e2e-send-msg" was created
    When I send a message "hello from e2e" to queue "e2e-send-msg"
    Then the command will succeed
    And queue "e2e-send-msg" will contain a message with body "hello from e2e"
