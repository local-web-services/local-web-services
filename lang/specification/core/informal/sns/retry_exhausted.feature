@sns @generated
Feature: Sns - All "Sns" "Delivery" Retries Are Exhausted

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @retry_exhausted @internal
  Scenario: all "sns" "delivery" retries are exhausted
    Given the delivery existed
    And the "sns" "delivery" was "IN_FLIGHT"
    And the retry count had reached the limit
    When all "sns" "delivery" retries are exhausted
    Then the "sns" "delivery" will be marked "DONE"
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @guard @negative @retry_exhausted @internal
  Scenario: all "sns" "delivery" retries are exhausted fails when the delivery did not exist
    Given the delivery did not exist
    When all "sns" "delivery" retries are exhausted
    Then the operation is rejected

  @guard @negative @retry_exhausted @internal
  Scenario: all "sns" "delivery" retries are exhausted fails when the "sns" "delivery" was not "IN_FLIGHT"
    Given the delivery existed
    And the "sns" "delivery" was not "IN_FLIGHT"
    When all "sns" "delivery" retries are exhausted
    Then the operation is rejected

  @guard @negative @retry_exhausted @internal
  Scenario: all "sns" "delivery" retries are exhausted fails when the retry count was below the limit
    Given the delivery existed
    And the "sns" "delivery" was "IN_FLIGHT"
    And the retry count was below the limit
    When all "sns" "delivery" retries are exhausted
    Then the operation is rejected
