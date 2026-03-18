@sns @generated
Feature: Sns - A Delivery Attempt Fails And Is Retried

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @delivery_fails @internal
  Scenario: a delivery attempt fails and is retried
    Given the delivery exists
    And the delivery is "IN_FLIGHT"
    And the retry count is below the limit
    When a delivery attempt fails and is retried
    Then the delivery retry count is incremented
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @standard @negative @delivery_fails @internal
  Scenario: a delivery attempt fails and is retried fails when the delivery does not exist
    Given the delivery does not exist
    When a delivery attempt fails and is retried
    Then the operation is rejected

  @standard @negative @delivery_fails @internal
  Scenario: a delivery attempt fails and is retried fails when the delivery is not "IN_FLIGHT"
    Given the delivery exists
    And the delivery is not "IN_FLIGHT"
    When a delivery attempt fails and is retried
    Then the operation is rejected

  @standard @negative @delivery_fails @internal
  Scenario: a delivery attempt fails and is retried fails when the retry count has reached the limit
    Given the delivery exists
    And the delivery is "IN_FLIGHT"
    And the retry count has reached the limit
    When a delivery attempt fails and is retried
    Then the operation is rejected
