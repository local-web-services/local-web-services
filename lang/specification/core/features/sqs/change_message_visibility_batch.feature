@sqs @change_message_visibility_batch @dataplane
Feature: SQS ChangeMessageVisibilityBatch

  @happy
  Scenario: Change visibility timeout of messages in batch
    Given a queue "e2e-chg-vis-batch" was created
    And a message "vis-batch-test" was sent to queue "e2e-chg-vis-batch"
    And a message was received from queue "e2e-chg-vis-batch"
    When I change message visibility in batch with timeout "60" for the received message in queue "e2e-chg-vis-batch"
    Then the command will succeed
