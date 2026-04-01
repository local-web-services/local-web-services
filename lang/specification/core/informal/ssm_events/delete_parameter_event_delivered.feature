@ssmevents @generated
Feature: SsmEvents - A "Ssm" "Parameter" Is Deleted And "Ssm" Delivers A "Deleted" "Eventbridge" "Event" To The "Eventbridge" "Bus"

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @delete_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" existed (not already "DELETED")
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "event" "slot" was "available"
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the "ssm" "parameter" will be deleted and the "DELETED" event will be "DELIVERED"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @delete_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @delete_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" fails when the "ssm" "parameter" is already "DELETED"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" is already "DELETED"
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @delete_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" fails when the "eventbridge" "bus" was "DELETED"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" existed (not already "DELETED")
    And the "eventbridge" "bus" was "DELETED"
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @delete_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" fails when no "eventbridge" "event" "slot" was "available"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" existed (not already "DELETED")
    And the "eventbridge" "bus" was "ACTIVE"
    And no "eventbridge" "event" "slot" was "available"
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected
