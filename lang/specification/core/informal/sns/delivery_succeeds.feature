@sns @generated
Feature: Sns - A "Sns" "Delivery" Attempt Succeeds

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @delivery_succeeds @internal
  Scenario: a "sns" "delivery" attempt succeeds
    Given the delivery existed
    And the "sns" "delivery" was "IN_FLIGHT"
    When a "sns" "delivery" attempt succeeds
    Then the "sns" "delivery" will be "DONE"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @delivery_succeeds @internal
  Scenario: a "sns" "delivery" attempt succeeds fails when the delivery did not exist
    Given the delivery did not exist
    When a "sns" "delivery" attempt succeeds
    Then the operation is rejected

  @guard @negative @delivery_succeeds @internal
  Scenario: a "sns" "delivery" attempt succeeds fails when the "sns" "delivery" was not "IN_FLIGHT"
    Given the delivery existed
    And the "sns" "delivery" was not "IN_FLIGHT"
    When a "sns" "delivery" attempt succeeds
    Then the operation is rejected
