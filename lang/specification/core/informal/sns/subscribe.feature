@sns @generated
Feature: Sns - An Endpoint Subscribes To A "Sns" "Topic"

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @subscribe
  Scenario: an endpoint subscribes to a "sns" "topic"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And an "sns" "subscription" "slot" was "available"
    When an endpoint subscribes to a "sns" "topic"
    Then the "sns" "subscription" will be "PENDING_CONFIRMATION" or "CONFIRMED"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @guard @negative @subscribe
  Scenario: an endpoint subscribes to a "sns" "topic" fails when the "sns" "topic" did not exist
    Given the "sns" "topic" did not exist
    When an endpoint subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe @lifecycle
  Scenario: an endpoint subscribes to a "sns" "topic" fails when the "sns" "topic" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When an endpoint subscribes to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @subscribe @capacity
  Scenario: an endpoint subscribes to a "sns" "topic" fails when no "sns" "subscription" "slot" was "available"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And no "sns" "subscription" "slot" was "available"
    When an endpoint subscribes to a "sns" "topic"
    Then the operation is rejected
