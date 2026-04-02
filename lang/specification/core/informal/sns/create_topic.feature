@sns @generated
Feature: Sns - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the "sns" "topic" did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the "sns" "topic" already existed
    Given the "sns" "topic" already existed
    When a "sns" "topic" is created
    Then the operation is rejected
