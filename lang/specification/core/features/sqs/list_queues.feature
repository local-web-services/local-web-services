@sqs @list_queues @controlplane
Feature: SQS ListQueues

  @happy
  Scenario: List queues includes a created queue
    Given a queue "e2e-list-q" was created
    When I list queues
    Then the command will succeed
    And the output will contain queue "e2e-list-q"
