@ssmevents @generated
Feature: SsmEvents - A Parameter Is Created And Ssm Delivers A Created Event To The Eventbridge Bus

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_event_delivered @internal
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given the "ssm" "parameter" did not already exist
    And the bus was "ACTIVE"
    And an event slot is available
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then the parameter will exist and the "CREATED" event will be "DELIVERED"
    And every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @guard @negative @put_parameter_event_delivered @internal
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @put_parameter_event_delivered @internal
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus fails when the bus was "DELETED"
    Given the "ssm" "parameter" did not already exist
    And the bus was "DELETED"
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @put_parameter_event_delivered @internal
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus fails when no event slot is available
    Given the "ssm" "parameter" did not already exist
    And the bus was "ACTIVE"
    And no event slot is available
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then the operation is rejected
