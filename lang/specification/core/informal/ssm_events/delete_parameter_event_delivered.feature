@ssmevents @generated
Feature: SsmEvents - A Parameter Is Deleted And Ssm Delivers A Deleted Event To The Eventbridge Bus

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given the parameter exists
    And the parameter "EXISTS" (not already "DELETED")
    And the bus is "ACTIVE"
    And an event slot is available
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the parameter is "DELETED" and the "DELETED" event is "DELIVERED"
    And every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @standard @negative @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus fails when the parameter does not exist
    Given the parameter does not exist
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus fails when the parameter is already "DELETED"
    Given the parameter exists
    And the parameter is already "DELETED"
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus fails when the bus is "DELETED"
    Given the parameter exists
    And the parameter "EXISTS" (not already "DELETED")
    And the bus is "DELETED"
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus fails when no event slot is available
    Given the parameter exists
    And the parameter "EXISTS" (not already "DELETED")
    And the bus is "ACTIVE"
    And no event slot is available
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the operation is rejected
