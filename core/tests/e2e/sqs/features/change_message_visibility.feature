@sqs @change_message_visibility @dataplane
Feature: SQS ChangeMessageVisibility

  @happy
  Scenario: Change visibility timeout of a message
    Given a queue "e2e-chg-vis" was created
    And a message "vis-test" was sent to queue "e2e-chg-vis"
    And a message was received from queue "e2e-chg-vis"
    When I change the visibility timeout to "60" for the received message in queue "e2e-chg-vis"
    Then the command will succeed
