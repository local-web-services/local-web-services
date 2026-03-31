@sns @generated
Feature: Sns - A "Sns" "Topic" Is Deleted

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @delete_topic
  Scenario: a "sns" "topic" is deleted
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    When a "sns" "topic" is deleted
    Then the "sns" "topic" will be "DELETED" and its subscriptions will be removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @delete_topic
  Scenario: a "sns" "topic" is deleted fails when the "sns" "topic" did not exist
    Given the "sns" "topic" did not exist
    When a "sns" "topic" is deleted
    Then the operation is rejected

  @guard @negative @delete_topic @lifecycle
  Scenario: a "sns" "topic" is deleted fails when the "sns" "topic" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When a "sns" "topic" is deleted
    Then the operation is rejected
