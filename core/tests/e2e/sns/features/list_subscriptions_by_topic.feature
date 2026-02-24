@sns @list_subscriptions_by_topic @controlplane
Feature: SNS ListSubscriptionsByTopic

  @happy
  Scenario: List subscriptions for a specific topic
    Given a topic "e2e-list-subs-topic" was created
    When I list subscriptions by topic "e2e-list-subs-topic"
    Then the command will succeed
