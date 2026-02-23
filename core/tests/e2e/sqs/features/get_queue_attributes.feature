@sqs @get_queue_attributes @controlplane
Feature: SQS GetQueueAttributes

  @happy
  Scenario: Get attributes of a queue
    Given a queue "e2e-getattr-q" was created
    When I get queue attributes for "e2e-getattr-q"
    Then the command will succeed
    And the output will contain "GetQueueAttributesResponse"
