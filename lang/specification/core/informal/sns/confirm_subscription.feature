@sns @generated
Feature: Sns - A Pending Subscription Is Confirmed

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @confirm_subscription @internal
  Scenario: a pending subscription is confirmed
    Given the subscription exists
    And the subscription is "PENDING_CONFIRMATION"
    And the subscription's topic exists
    And the subscription's topic is "ACTIVE"
    When a pending subscription is confirmed
    Then the subscription is "CONFIRMED"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @standard @negative @confirm_subscription @internal
  Scenario: a pending subscription is confirmed fails when the subscription does not exist
    Given the subscription does not exist
    When a pending subscription is confirmed
    Then the operation is rejected

  @standard @negative @confirm_subscription @internal
  Scenario: a pending subscription is confirmed fails when the subscription is not "PENDING_CONFIRMATION"
    Given the subscription exists
    And the subscription is not "PENDING_CONFIRMATION"
    When a pending subscription is confirmed
    Then the operation is rejected

  @standard @negative @confirm_subscription @internal
  Scenario: a pending subscription is confirmed fails when the subscription's topic does not exist
    Given the subscription exists
    And the subscription is "PENDING_CONFIRMATION"
    And the subscription's topic does not exist
    When a pending subscription is confirmed
    Then the operation is rejected

  @standard @negative @confirm_subscription @lifecycle @internal
  Scenario: a pending subscription is confirmed fails when the subscription's topic is not "ACTIVE"
    Given the subscription exists
    And the subscription is "PENDING_CONFIRMATION"
    And the subscription's topic exists
    And the subscription's topic is not "ACTIVE"
    When a pending subscription is confirmed
    Then the operation is rejected
