@sns @generated
Feature: Sns - A "Sns" "Message" Is Published To A "Sns" "Topic"

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @publish
  Scenario: a "sns" "message" is published to a "sns" "topic"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the "sns" "subscription" belongs to this "sns" "topic"
    And a delivery slot is available
    When a "sns" "message" is published to a "sns" "topic"
    Then the "sns" "message" will be delivered to confirmed subscriptions
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @publish
  Scenario: a "sns" "message" is published to a "sns" "topic" fails when the "sns" "topic" did not exist
    Given the "sns" "topic" did not exist
    When a "sns" "message" is published to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @publish @lifecycle
  Scenario: a "sns" "message" is published to a "sns" "topic" fails when the "sns" "topic" was not "ACTIVE"
    Given the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When a "sns" "message" is published to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @publish
  Scenario: a "sns" "message" is published to a "sns" "topic" fails when no confirmed subscription existed for the "sns" "topic"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And no confirmed subscription existed for the "sns" "topic"
    When a "sns" "message" is published to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @publish
  Scenario: a "sns" "message" is published to a "sns" "topic" fails when the "sns" "subscription" does not belong to this "sns" "topic"
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the "sns" "subscription" does not belong to this "sns" "topic"
    When a "sns" "message" is published to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @publish @capacity
  Scenario: a "sns" "message" is published to a "sns" "topic" fails when no delivery slot is available
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And a confirmed subscription existed for the "sns" "topic"
    And the "sns" "subscription" belongs to this "sns" "topic"
    And no delivery slot is available
    When a "sns" "message" is published to a "sns" "topic"
    Then the operation is rejected
