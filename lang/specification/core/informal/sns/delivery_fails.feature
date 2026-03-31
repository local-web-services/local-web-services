@sns @generated
Feature: Sns - A "Sns" "Delivery" Attempt Fails And Is Retried

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @delivery_fails @internal
  Scenario: a "sns" "delivery" attempt fails and is retried
    Given the delivery existed
    And the "sns" "delivery" was "IN_FLIGHT"
    And the retry count was below the limit
    When a "sns" "delivery" attempt fails and is retried
    Then the "sns" "delivery" retry count will be incremented
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @delivery_fails @internal
  Scenario: a "sns" "delivery" attempt fails and is retried fails when the delivery did not exist
    Given the delivery did not exist
    When a "sns" "delivery" attempt fails and is retried
    Then the operation is rejected

  @guard @negative @delivery_fails @internal
  Scenario: a "sns" "delivery" attempt fails and is retried fails when the "sns" "delivery" was not "IN_FLIGHT"
    Given the delivery existed
    And the "sns" "delivery" was not "IN_FLIGHT"
    When a "sns" "delivery" attempt fails and is retried
    Then the operation is rejected

  @guard @negative @delivery_fails @internal
  Scenario: a "sns" "delivery" attempt fails and is retried fails when the retry count had reached the limit
    Given the delivery existed
    And the "sns" "delivery" was "IN_FLIGHT"
    And the retry count had reached the limit
    When a "sns" "delivery" attempt fails and is retried
    Then the operation is rejected
