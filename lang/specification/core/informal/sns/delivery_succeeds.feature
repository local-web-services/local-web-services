@sns @generated
Feature: Sns - A "Sns" "Delivery" Attempt Succeeds

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @delivery_succeeds @internal
  Scenario: a "sns" "delivery" attempt succeeds
    Given the "sns" "delivery" existed
    And the "sns" "delivery" was "IN_FLIGHT"
    When a "sns" "delivery" attempt succeeds
    Then the "sns" "delivery" will be "DONE"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @guard @negative @delivery_succeeds @internal
  Scenario: a "sns" "delivery" attempt succeeds fails when the "sns" "delivery" did not exist
    Given the "sns" "delivery" did not exist
    When a "sns" "delivery" attempt succeeds
    Then the operation is rejected

  @guard @negative @delivery_succeeds @internal
  Scenario: a "sns" "delivery" attempt succeeds fails when the "sns" "delivery" was not "IN_FLIGHT"
    Given the "sns" "delivery" existed
    And the "sns" "delivery" was not "IN_FLIGHT"
    When a "sns" "delivery" attempt succeeds
    Then the operation is rejected
