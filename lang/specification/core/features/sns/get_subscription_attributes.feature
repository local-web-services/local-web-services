@sns @get_subscription_attributes @controlplane
Feature: SNS GetSubscriptionAttributes

  @happy
  Scenario: Get attributes of a subscription
    Given a topic "e2e-get-sub-attrs" was created
    And an SQS subscription to "arn:aws:sqs:us-east-1:000000000000:e2e-get-sub-attrs-q" was added to topic "e2e-get-sub-attrs"
    When I get subscription attributes for the subscription on topic "e2e-get-sub-attrs"
    Then the command will succeed
