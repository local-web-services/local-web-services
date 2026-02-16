@sqs @delete_message_batch @dataplane
Feature: SQS DeleteMessageBatch

  @happy
  Scenario: Delete messages in batch
    Given a queue "e2e-delmsg-batch" was created
    And a message "batch-delete-me" was sent to queue "e2e-delmsg-batch"
    And a message was received from queue "e2e-delmsg-batch"
    When I delete messages in batch for the received message in queue "e2e-delmsg-batch"
    Then the command will succeed
