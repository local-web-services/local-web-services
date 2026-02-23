@sqs @purge_queue @controlplane
Feature: SQS PurgeQueue

  @happy
  Scenario: Purge all messages from a queue
    Given a queue "e2e-purge-q" was created
    And a message "msg1" was sent to queue "e2e-purge-q"
    When I purge queue "e2e-purge-q"
    Then the command will succeed
    And queue "e2e-purge-q" will have approximate message count "0"
