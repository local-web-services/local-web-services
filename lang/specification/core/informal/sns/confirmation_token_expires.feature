@sns @generated
Feature: Sns - A Subscription Confirmation Token Expires

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @confirmation_token_expires @internal
  Scenario: a subscription confirmation token expires
    Given the subscription exists
    And the subscription is "PENDING_CONFIRMATION"
    When a subscription confirmation token expires
    Then the pending subscription is "DELETED"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @confirmation_token_expires @internal
  Scenario: a subscription confirmation token expires fails when the subscription does not exist
    Given the subscription does not exist
    When a subscription confirmation token expires
    Then the operation is rejected

  @guard @negative @confirmation_token_expires @internal
  Scenario: a subscription confirmation token expires fails when the subscription is not "PENDING_CONFIRMATION"
    Given the subscription exists
    And the subscription is not "PENDING_CONFIRMATION"
    When a subscription confirmation token expires
    Then the operation is rejected
