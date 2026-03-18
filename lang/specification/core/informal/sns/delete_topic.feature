@sns @generated
Feature: Sns - An Sns Topic Is Deleted

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @delete_topic
  Scenario: an "SNS" topic is deleted
    Given the topic exists
    And the topic is "ACTIVE"
    When an "SNS" topic is deleted
    Then the topic is "DELETED" and its subscriptions are removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @standard @negative @delete_topic
  Scenario: an "SNS" topic is deleted fails when the topic does not exist
    Given the topic does not exist
    When an "SNS" topic is deleted
    Then the operation is rejected

  @standard @negative @delete_topic @lifecycle @internal
  Scenario: an "SNS" topic is deleted fails when the topic is not "ACTIVE"
    Given the topic exists
    And the topic is not "ACTIVE"
    When an "SNS" topic is deleted
    Then the operation is rejected
