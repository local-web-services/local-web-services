@sns @subscribe @controlplane
Feature: SNS Subscribe

  @happy
  Scenario: Subscribe an SQS queue to a topic
    Given a topic "e2e-sub-topic" was created
    When I subscribe "arn:aws:sqs:us-east-1:000000000000:e2e-sub-queue" with protocol "sqs" to the topic "e2e-sub-topic"
    Then the command will succeed
    And the topic "e2e-sub-topic" will have a subscription in the subscription list
