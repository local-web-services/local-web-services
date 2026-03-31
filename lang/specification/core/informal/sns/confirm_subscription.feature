@sns @generated
Feature: Sns - A Pending "Sns" "Subscription" Is Confirmed

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @confirm_subscription
  Scenario: a pending "sns" "subscription" is confirmed
    Given the "sns" "subscription" existed
    And the "sns" "subscription" was "PENDING_CONFIRMATION"
    And the "sns" "subscription"'s sns topic existed
    And the "sns" "subscription"'s "sns" "topic" was "ACTIVE"
    When a pending "sns" "subscription" is confirmed
    Then the "sns" "subscription" will be "CONFIRMED"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @confirm_subscription
  Scenario: a pending "sns" "subscription" is confirmed fails when the "sns" "subscription" did not exist
    Given the "sns" "subscription" did not exist
    When a pending "sns" "subscription" is confirmed
    Then the operation is rejected

  @guard @negative @confirm_subscription
  Scenario: a pending "sns" "subscription" is confirmed fails when the "sns" "subscription" was not "PENDING_CONFIRMATION"
    Given the "sns" "subscription" existed
    And the "sns" "subscription" was not "PENDING_CONFIRMATION"
    When a pending "sns" "subscription" is confirmed
    Then the operation is rejected

  @guard @negative @confirm_subscription
  Scenario: a pending "sns" "subscription" is confirmed fails when the "sns" "subscription"'s sns topic did not exist
    Given the "sns" "subscription" existed
    And the "sns" "subscription" was "PENDING_CONFIRMATION"
    And the "sns" "subscription"'s sns topic did not exist
    When a pending "sns" "subscription" is confirmed
    Then the operation is rejected

  @guard @negative @confirm_subscription @lifecycle
  Scenario: a pending "sns" "subscription" is confirmed fails when the "sns" "subscription"'s "sns" "topic" was not "ACTIVE"
    Given the "sns" "subscription" existed
    And the "sns" "subscription" was "PENDING_CONFIRMATION"
    And the "sns" "subscription"'s sns topic existed
    And the "sns" "subscription"'s "sns" "topic" was not "ACTIVE"
    When a pending "sns" "subscription" is confirmed
    Then the operation is rejected
