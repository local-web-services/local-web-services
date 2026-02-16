@sqs @list_dead_letter_source_queues @controlplane
Feature: SQS ListDeadLetterSourceQueues

  @happy
  Scenario: List dead letter source queues
    Given a queue "e2e-list-dlq-src" was created
    When I list dead letter source queues for "e2e-list-dlq-src"
    Then the command will succeed
