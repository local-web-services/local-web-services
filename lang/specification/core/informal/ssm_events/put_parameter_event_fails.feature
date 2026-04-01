@ssmevents @generated
Feature: SsmEvents - A Parameter Is Created But The Created Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_event_fails @internal
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given the "ssm" "parameter" did not already exist
    And the bus was "DELETED"
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then the parameter will exist but no event will be delivered
    And every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @guard @negative @put_parameter_event_fails @internal
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @put_parameter_event_fails @internal
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted fails when the bus was not "DELETED"
    Given the "ssm" "parameter" did not already exist
    And the bus was not "DELETED"
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then the operation is rejected
