@sqs @set_queue_attributes @controlplane
Feature: SQS SetQueueAttributes

  @happy
  Scenario: Set attributes on a queue
    Given a queue "e2e-set-queue-attrs" was created
    When I set queue attributes '{"VisibilityTimeout":"30"}' on queue "e2e-set-queue-attrs"
    Then the command will succeed
    And queue "e2e-set-queue-attrs" will have attribute "VisibilityTimeout" equal to "30"
