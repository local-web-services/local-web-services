@sqs @delete_message @dataplane
Feature: SQS DeleteMessage

  @happy
  Scenario: Delete a message from a queue
    Given a queue "e2e-delmsg" was created
    And a message "to-delete" was sent to queue "e2e-delmsg"
    And a message was received from queue "e2e-delmsg"
    When I delete the received message from queue "e2e-delmsg"
    Then the command will succeed
    And queue "e2e-delmsg" will have approximate message count "0"
