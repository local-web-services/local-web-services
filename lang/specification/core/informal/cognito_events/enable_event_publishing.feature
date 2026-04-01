@cognitoevents @generated
Feature: CognitoEvents - Eventbridge Publishing Was "Enabled" On The "Cognito" "User" Pool

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @enable_event_publishing
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has no EventBridge configuration
    And the "eventbridge" "bus" existed and was "ACTIVE"
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Then the "cognito" "user pool" will send user events to the bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @enable_event_publishing @lifecycle
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool fails when the "cognito" "user pool" did not exist or was "ACTIVE"
    Given the "cognito" "user pool" did not exist or was "ACTIVE"
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Then the operation is rejected

  @guard @negative @enable_event_publishing
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool fails when the "cognito" "user pool" already has an EventBridge configuration
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" already has an EventBridge configuration
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Then the operation is rejected

  @guard @negative @enable_event_publishing
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool fails when the "eventbridge" "bus" did not exist or was "ACTIVE"
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has no EventBridge configuration
    And the "eventbridge" "bus" did not exist or was "ACTIVE"
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Then the operation is rejected
