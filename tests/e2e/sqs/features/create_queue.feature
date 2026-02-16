@sqs @create_queue @controlplane
Feature: SQS CreateQueue

  @happy
  Scenario: Create a new queue
    When I create a queue named "e2e-create-q"
    Then the command will succeed
    And the queue "e2e-create-q" will appear in the queue list
