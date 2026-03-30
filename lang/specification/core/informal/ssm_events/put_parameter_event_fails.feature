@ssmevents @generated
Feature: SsmEvents - A Parameter Is Created But The Created Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_event_fails @internal
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given the parameter does not already exist
    And the bus is "DELETED"
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then the parameter "EXISTS" but no event is delivered
    And every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @guard @negative @put_parameter_event_fails @internal
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted fails when the parameter already exists
    Given the parameter already exists
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @put_parameter_event_fails @internal
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted fails when the bus is not "DELETED"
    Given the parameter does not already exist
    And the bus is not "DELETED"
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then the operation is rejected
