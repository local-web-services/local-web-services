@sns @generated
Feature: Sns - A "Sns" "Delivery" Attempt Fails And Is Retried

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @delivery_fails @internal
  Scenario: a "sns" "delivery" attempt fails and is retried
    Given the "sns" "delivery" existed
    And the "sns" "delivery" was "IN_FLIGHT"
    And the "sns" "delivery" retry count was below the limit
    When a "sns" "delivery" attempt fails and is retried
    Then the "sns" "delivery" retry count will be incremented
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @guard @negative @delivery_fails @internal
  Scenario: a "sns" "delivery" attempt fails and is retried fails when the "sns" "delivery" did not exist
    Given the "sns" "delivery" did not exist
    When a "sns" "delivery" attempt fails and is retried
    Then the operation is rejected

  @guard @negative @delivery_fails @internal
  Scenario: a "sns" "delivery" attempt fails and is retried fails when the "sns" "delivery" was not "IN_FLIGHT"
    Given the "sns" "delivery" existed
    And the "sns" "delivery" was not "IN_FLIGHT"
    When a "sns" "delivery" attempt fails and is retried
    Then the operation is rejected

  @guard @negative @delivery_fails @internal
  Scenario: a "sns" "delivery" attempt fails and is retried fails when the "sns" "delivery" retry count had reached the limit
    Given the "sns" "delivery" existed
    And the "sns" "delivery" was "IN_FLIGHT"
    And the "sns" "delivery" retry count had reached the limit
    When a "sns" "delivery" attempt fails and is retried
    Then the operation is rejected
