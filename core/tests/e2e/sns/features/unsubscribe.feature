@sns @unsubscribe @controlplane
Feature: SNS Unsubscribe

  @happy
  Scenario: Unsubscribe from a topic
    Given a topic "e2e-unsub-topic" was created
    And an SQS subscription to "arn:aws:sqs:us-east-1:000000000000:e2e-unsub-queue" was added to topic "e2e-unsub-topic"
    When I unsubscribe the subscription on topic "e2e-unsub-topic"
    Then the command will succeed
    And the topic "e2e-unsub-topic" will not have a subscription in the subscription list
