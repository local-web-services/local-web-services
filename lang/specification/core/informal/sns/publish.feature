@sns @generated
Feature: Sns - A Message Is Published To A Topic

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @publish
  Scenario: a message is published to a topic
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscription belongs to this topic
    And a delivery slot is available
    When a message is published to a topic
    Then the message is delivered to confirmed subscriptions
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @standard @negative @publish
  Scenario: a message is published to a topic fails when the topic does not exist
    Given the topic does not exist
    When a message is published to a topic
    Then the operation is rejected

  @standard @negative @publish @lifecycle
  Scenario: a message is published to a topic fails when the topic is not "ACTIVE"
    Given the topic exists
    And the topic is not "ACTIVE"
    When a message is published to a topic
    Then the operation is rejected

  @standard @negative @publish
  Scenario: a message is published to a topic fails when no confirmed subscription exists for the topic
    Given the topic exists
    And the topic is "ACTIVE"
    And no confirmed subscription exists for the topic
    When a message is published to a topic
    Then the operation is rejected

  @standard @negative @publish
  Scenario: a message is published to a topic fails when the subscription does not belong to this topic
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscription does not belong to this topic
    When a message is published to a topic
    Then the operation is rejected

  @standard @negative @publish @capacity
  Scenario: a message is published to a topic fails when no delivery slot is available
    Given the topic exists
    And the topic is "ACTIVE"
    And a confirmed subscription exists for the topic
    And the subscription belongs to this topic
    And no delivery slot is available
    When a message is published to a topic
    Then the operation is rejected
