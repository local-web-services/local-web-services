@sqs @send_message_batch @dataplane
Feature: SQS SendMessageBatch

  @happy
  Scenario: Send messages in batch
    Given a queue "e2e-send-msg-batch" was created
    When I send a message batch with entries '[{"Id":"1","MessageBody":"msg1"}]' to queue "e2e-send-msg-batch"
    Then the command will succeed
    And queue "e2e-send-msg-batch" will contain a message with body "msg1"
