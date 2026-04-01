@cognitoevents @generated
Feature: CognitoEvents - The "Eventbridge" "Bus" Is Deleted

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @delete_event_bus
  Scenario: the "eventbridge" "bus" is deleted
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    When the "eventbridge" "bus" is deleted
    Then the "eventbridge" "bus" will be deleted and Cognito event delivery will fail
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @delete_event_bus
  Scenario: the "eventbridge" "bus" is deleted fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When the "eventbridge" "bus" is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus @lifecycle
  Scenario: the "eventbridge" "bus" is deleted fails when the "eventbridge" "bus" is already "DELETED"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" is already "DELETED"
    When the "eventbridge" "bus" is deleted
    Then the operation is rejected
