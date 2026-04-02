@ssmevents @generated
Feature: SsmEvents - A "Ssm" "Parameter" Is Created But The "Created" "Eventbridge" "Event" Delivery Fails Because The "Eventbridge" "Bus" Is Deleted

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_event_fails @internal
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given the "ssm" "parameter" did not already exist
    And the "eventbridge" "bus" was "DELETED"
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Then the "ssm" "parameter" will exist but no "eventbridge" "event" will be delivered
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @put_parameter_event_fails @internal
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Then the operation is rejected

  @guard @negative @put_parameter_event_fails @internal
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted fails when the "eventbridge" "bus" was not "DELETED"
    Given the "ssm" "parameter" did not already exist
    And the "eventbridge" "bus" was not "DELETED"
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Then the operation is rejected
