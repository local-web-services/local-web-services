@sns @set_subscription_attributes @controlplane
Feature: SNS SetSubscriptionAttributes

  @happy
  Scenario: Set attributes on a subscription
    Given a topic "e2e-set-sub-attrs" was created
    And an SQS subscription to "arn:aws:sqs:us-east-1:000000000000:e2e-set-sub-attrs-q" was added to topic "e2e-set-sub-attrs"
    When I set subscription attribute "RawMessageDelivery" to "true" for the subscription on topic "e2e-set-sub-attrs"
    Then the command will succeed
    And the subscription on topic "e2e-set-sub-attrs" will have attribute "RawMessageDelivery" equal to "true"
