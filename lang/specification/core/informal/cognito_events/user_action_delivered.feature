@cognitoevents @generated
Feature: CognitoEvents - A "Cognito" "User" Action Occurs In The "Cognito" "User Pool" And Cognito Delivers The Event To The Eventbridge Bus

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @user_action_delivered @internal
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has an EventBridge configuration
    And the bus was "ACTIVE"
    And an event slot is available
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Then the event will be "DELIVERED" to the bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @user_action_delivered @internal
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus fails when the "cognito" "user pool" did not exist or was "ACTIVE"
    Given the "cognito" "user pool" did not exist or was "ACTIVE"
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @user_action_delivered @internal
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus fails when the "cognito" "user pool" has no EventBridge configuration
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has no EventBridge configuration
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @user_action_delivered @internal
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus fails when the bus was "DELETED"
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has an EventBridge configuration
    And the bus was "DELETED"
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @user_action_delivered @internal
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus fails when no event slot is available
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has an EventBridge configuration
    And the bus was "ACTIVE"
    And no event slot is available
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Then the operation is rejected
