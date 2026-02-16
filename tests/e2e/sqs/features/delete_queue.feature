@sqs @delete_queue @controlplane
Feature: SQS DeleteQueue

  @happy
  Scenario: Delete an existing queue
    Given a queue "e2e-del-q" was created
    When I delete the queue "e2e-del-q"
    Then the command will succeed
    And the queue "e2e-del-q" will not appear in the queue list
