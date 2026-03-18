@cognitoevents @generated
Feature: CognitoEvents - A User Action Occurs But Event Delivery Fails Because The Bus Has Been Deleted

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @user_action_delivery_fails @internal
  Scenario: a user action occurs but event delivery fails because the bus has been deleted
    Given the pool exists and is "ACTIVE"
    And the pool has an EventBridge configuration
    And the bus is "DELETED"
    And an event slot is available
    When a user action occurs but event delivery fails because the bus has been deleted
    Then the event delivery "FAILED"
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @user_action_delivery_fails @internal
  Scenario: a user action occurs but event delivery fails because the bus has been deleted fails when the pool does not exist or is not "ACTIVE"
    Given the pool does not exist or is not "ACTIVE"
    When a user action occurs but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @standard @negative @user_action_delivery_fails @internal
  Scenario: a user action occurs but event delivery fails because the bus has been deleted fails when the pool has no EventBridge configuration
    Given the pool exists and is "ACTIVE"
    And the pool has no EventBridge configuration
    When a user action occurs but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @standard @negative @user_action_delivery_fails @internal
  Scenario: a user action occurs but event delivery fails because the bus has been deleted fails when the bus is not "DELETED"
    Given the pool exists and is "ACTIVE"
    And the pool has an EventBridge configuration
    And the bus is not "DELETED"
    When a user action occurs but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @standard @negative @user_action_delivery_fails @internal
  Scenario: a user action occurs but event delivery fails because the bus has been deleted fails when no event slot is available
    Given the pool exists and is "ACTIVE"
    And the pool has an EventBridge configuration
    And the bus is "DELETED"
    And no event slot is available
    When a user action occurs but event delivery fails because the bus has been deleted
    Then the operation is rejected
