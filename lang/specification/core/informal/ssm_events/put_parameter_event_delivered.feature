@ssmevents @generated
Feature: SsmEvents - A Parameter Is Created And Ssm Delivers A Created Event To The Eventbridge Bus

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_event_delivered @internal
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given the parameter does not already exist
    And the bus is "ACTIVE"
    And an event slot is available
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then the parameter "EXISTS" and the "CREATED" event is "DELIVERED"
    And every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @standard @negative @put_parameter_event_delivered @internal
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus fails when the parameter already exists
    Given the parameter already exists
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @put_parameter_event_delivered @internal
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus fails when the bus is "DELETED"
    Given the parameter does not already exist
    And the bus is "DELETED"
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @put_parameter_event_delivered @internal
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus fails when no event slot is available
    Given the parameter does not already exist
    And the bus is "ACTIVE"
    And no event slot is available
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected
