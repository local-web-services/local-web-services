@sns @generated
Feature: Sns - A "Sns" "Subscription" Is Removed

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @unsubscribe
  Scenario: a "sns" "subscription" is removed
    Given the "sns" "subscription" existed
    And the "sns" "subscription" was "CONFIRMED"
    When a "sns" "subscription" is removed
    Then the "sns" "subscription" will be "DELETED"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @unsubscribe
  Scenario: a "sns" "subscription" is removed fails when the "sns" "subscription" did not exist
    Given the "sns" "subscription" did not exist
    When a "sns" "subscription" is removed
    Then the operation is rejected

  @guard @negative @unsubscribe @lifecycle
  Scenario: a "sns" "subscription" is removed fails when the "sns" "subscription" was not "CONFIRMED"
    Given the "sns" "subscription" existed
    And the "sns" "subscription" was not "CONFIRMED"
    When a "sns" "subscription" is removed
    Then the operation is rejected
