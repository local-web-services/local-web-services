@sns @generated
Feature: Sns - All Delivery Retries Are Exhausted

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @retry_exhausted @internal
  Scenario: all delivery retries are exhausted
    Given the delivery exists
    And the delivery is "IN_FLIGHT"
    And the retry count has reached the limit
    When all delivery retries are exhausted
    Then the delivery is marked "DONE"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @standard @negative @retry_exhausted @internal
  Scenario: all delivery retries are exhausted fails when the delivery does not exist
    Given the delivery does not exist
    When all delivery retries are exhausted
    Then the operation is rejected

  @standard @negative @retry_exhausted @internal
  Scenario: all delivery retries are exhausted fails when the delivery is not "IN_FLIGHT"
    Given the delivery exists
    And the delivery is not "IN_FLIGHT"
    When all delivery retries are exhausted
    Then the operation is rejected

  @standard @negative @retry_exhausted @internal
  Scenario: all delivery retries are exhausted fails when the retry count is below the limit
    Given the delivery exists
    And the delivery is "IN_FLIGHT"
    And the retry count is below the limit
    When all delivery retries are exhausted
    Then the operation is rejected
