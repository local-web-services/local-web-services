@sns @generated
Feature: Sns - An Endpoint Subscribes To A Topic

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @subscribe
  Scenario: an endpoint subscribes to a topic
    Given the topic exists
    And the topic is "ACTIVE"
    And the subscription slot is available
    When an endpoint subscribes to a topic
    Then the subscription is "PENDING_CONFIRMATION" or "CONFIRMED"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @standard @negative @subscribe
  Scenario: an endpoint subscribes to a topic fails when the topic does not exist
    Given the topic does not exist
    When an endpoint subscribes to a topic
    Then the operation is rejected

  @standard @negative @subscribe @lifecycle
  Scenario: an endpoint subscribes to a topic fails when the topic is not "ACTIVE"
    Given the topic exists
    And the topic is not "ACTIVE"
    When an endpoint subscribes to a topic
    Then the operation is rejected

  @standard @negative @subscribe @capacity
  Scenario: an endpoint subscribes to a topic fails when the subscription slot is not available
    Given the topic exists
    And the topic is "ACTIVE"
    And the subscription slot is not available
    When an endpoint subscribes to a topic
    Then the operation is rejected
