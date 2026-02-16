@sqs @list_queue_tags @controlplane
Feature: SQS ListQueueTags

  @happy
  Scenario: List tags of a queue
    Given a queue "e2e-list-q-tags" was created
    When I list queue tags for "e2e-list-q-tags"
    Then the command will succeed
