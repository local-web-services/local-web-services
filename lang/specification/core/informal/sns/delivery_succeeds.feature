@sns @generated
Feature: Sns - A Delivery Attempt Succeeds

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @delivery_succeeds @internal
  Scenario: a delivery attempt succeeds
    Given the delivery exists
    And the delivery is "IN_FLIGHT"
    When a delivery attempt succeeds
    Then the delivery is "DONE"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @delivery_succeeds @internal
  Scenario: a delivery attempt succeeds fails when the delivery does not exist
    Given the delivery does not exist
    When a delivery attempt succeeds
    Then the operation is rejected

  @guard @negative @delivery_succeeds @internal
  Scenario: a delivery attempt succeeds fails when the delivery is not "IN_FLIGHT"
    Given the delivery exists
    And the delivery is not "IN_FLIGHT"
    When a delivery attempt succeeds
    Then the operation is rejected
