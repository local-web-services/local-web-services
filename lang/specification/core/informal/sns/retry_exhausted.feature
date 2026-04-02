@sns @generated
Feature: Sns - All "Sns" "Delivery" Retries Are Exhausted

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @retry_exhausted @internal
  Scenario: all "sns" "delivery" retries are exhausted
    Given the "sns" "delivery" existed
    And the "sns" "delivery" was "IN_FLIGHT"
    And the "sns" "delivery" retry count had reached the limit
    When all "sns" "delivery" retries are exhausted
    Then the "sns" "delivery" will be marked "DONE"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @guard @negative @retry_exhausted @internal
  Scenario: all "sns" "delivery" retries are exhausted fails when the "sns" "delivery" did not exist
    Given the "sns" "delivery" did not exist
    When all "sns" "delivery" retries are exhausted
    Then the operation is rejected

  @guard @negative @retry_exhausted @internal
  Scenario: all "sns" "delivery" retries are exhausted fails when the "sns" "delivery" was not "IN_FLIGHT"
    Given the "sns" "delivery" existed
    And the "sns" "delivery" was not "IN_FLIGHT"
    When all "sns" "delivery" retries are exhausted
    Then the operation is rejected

  @guard @negative @retry_exhausted @internal
  Scenario: all "sns" "delivery" retries are exhausted fails when the "sns" "delivery" retry count was below the limit
    Given the "sns" "delivery" existed
    And the "sns" "delivery" was "IN_FLIGHT"
    And the "sns" "delivery" retry count was below the limit
    When all "sns" "delivery" retries are exhausted
    Then the operation is rejected
