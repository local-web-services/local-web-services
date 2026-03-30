@sns @generated
Feature: Sns - A Subscription Is Removed

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @unsubscribe
  Scenario: a subscription is removed
    Given the subscription exists
    And the subscription is "CONFIRMED"
    When a subscription is removed
    Then the subscription is "DELETED"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @unsubscribe
  Scenario: a subscription is removed fails when the subscription does not exist
    Given the subscription does not exist
    When a subscription is removed
    Then the operation is rejected

  @guard @negative @unsubscribe @lifecycle
  Scenario: a subscription is removed fails when the subscription is not "CONFIRMED"
    Given the subscription exists
    And the subscription is not "CONFIRMED"
    When a subscription is removed
    Then the operation is rejected
