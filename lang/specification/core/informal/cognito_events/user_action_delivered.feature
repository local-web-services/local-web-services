@cognitoevents @generated
Feature: CognitoEvents - A User Action Occurs In The Pool And Cognito Delivers The Event To The Eventbridge Bus

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @user_action_delivered @internal
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given the pool exists and is "ACTIVE"
    And the pool has an EventBridge configuration
    And the bus is "ACTIVE"
    And an event slot is available
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Then the event is "DELIVERED" to the bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @user_action_delivered @internal
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus fails when the pool does not exist or is not "ACTIVE"
    Given the pool does not exist or is not "ACTIVE"
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @user_action_delivered @internal
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus fails when the pool has no EventBridge configuration
    Given the pool exists and is "ACTIVE"
    And the pool has no EventBridge configuration
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @user_action_delivered @internal
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus fails when the bus is "DELETED"
    Given the pool exists and is "ACTIVE"
    And the pool has an EventBridge configuration
    And the bus is "DELETED"
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @user_action_delivered @internal
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus fails when no event slot is available
    Given the pool exists and is "ACTIVE"
    And the pool has an EventBridge configuration
    And the bus is "ACTIVE"
    And no event slot is available
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Then the operation is rejected
