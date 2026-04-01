@ssmevents @generated
Feature: SsmEvents - A "Ssm" "Parameter" Is Created And "Ssm" Delivers A "Created" "Eventbridge" "Event" To The "Eventbridge" "Bus"

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given the "ssm" "parameter" did not already exist
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "event" "slot" was "available"
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the "ssm" "parameter" will exist and the "eventbridge" "CREATED" "event" will be "DELIVERED"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @put_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" fails when the "eventbridge" "bus" was "DELETED"
    Given the "ssm" "parameter" did not already exist
    And the "eventbridge" "bus" was "DELETED"
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_parameter_event_delivered @internal
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" fails when no "eventbridge" "event" "slot" was "available"
    Given the "ssm" "parameter" did not already exist
    And the "eventbridge" "bus" was "ACTIVE"
    And no "eventbridge" "event" "slot" was "available"
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Then the operation is rejected
