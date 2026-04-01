@cognitoevents @generated
Feature: CognitoEvents - A "Cognito" "User" Action Occurs But Event Delivery Fails Because The Bus Has Been Deleted

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @user_action_delivery_fails @internal
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has an EventBridge configuration
    And the bus was "DELETED"
    And an event slot is available
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Then the event delivery "FAILED"
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @user_action_delivery_fails @internal
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted fails when the "cognito" "user pool" did not exist or was "ACTIVE"
    Given the "cognito" "user pool" did not exist or was "ACTIVE"
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @guard @negative @user_action_delivery_fails @internal
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted fails when the "cognito" "user pool" has no EventBridge configuration
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has no EventBridge configuration
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @guard @negative @user_action_delivery_fails @internal
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted fails when the bus was not "DELETED"
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has an EventBridge configuration
    And the bus was not "DELETED"
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Then the operation is rejected

  @guard @negative @user_action_delivery_fails @internal
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted fails when no event slot is available
    Given the "cognito" "user pool" existed and was "ACTIVE"
    And the "cognito" "user pool" has an EventBridge configuration
    And the bus was "DELETED"
    And no event slot is available
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Then the operation is rejected
