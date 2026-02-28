@sns @list_subscriptions @controlplane
Feature: SNS ListSubscriptions

  @happy
  Scenario: List all subscriptions
    When I list subscriptions
    Then the command will succeed
    And the output will contain a ListSubscriptionsResponse
