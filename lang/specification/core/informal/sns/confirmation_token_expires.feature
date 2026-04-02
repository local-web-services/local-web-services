@sns @generated
Feature: Sns - A "Sns" "Subscription" Confirmation Token Expires

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @minimal @happy @confirmation_token_expires @internal
  Scenario: a "sns" "subscription" confirmation token expires
    Given the "sns" "subscription" existed
    And the "sns" "subscription" was "PENDING_CONFIRMATION"
    When a "sns" "subscription" confirmation token expires
    Then the pending "sns" "subscription" will be "DELETED"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @guard @negative @confirmation_token_expires @internal
  Scenario: a "sns" "subscription" confirmation token expires fails when the "sns" "subscription" did not exist
    Given the "sns" "subscription" did not exist
    When a "sns" "subscription" confirmation token expires
    Then the operation is rejected

  @guard @negative @confirmation_token_expires @internal
  Scenario: a "sns" "subscription" confirmation token expires fails when the "sns" "subscription" was not "PENDING_CONFIRMATION"
    Given the "sns" "subscription" existed
    And the "sns" "subscription" was not "PENDING_CONFIRMATION"
    When a "sns" "subscription" confirmation token expires
    Then the operation is rejected
