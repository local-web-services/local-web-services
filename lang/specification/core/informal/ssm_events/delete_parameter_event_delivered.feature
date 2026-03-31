@ssmevents @generated
Feature: SsmEvents - A Parameter Is Deleted And Ssm Delivers A Deleted Event To The Eventbridge Bus

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" existed (not already "DELETED")
    And the bus was "ACTIVE"
    And an event slot is available
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the "ssm" "parameter" will be deleted and the "DELETED" event will be "DELIVERED"
    And every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @guard @negative @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus fails when the parameter is already "DELETED"
    Given the "ssm" "parameter" existed
    And the parameter is already "DELETED"
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus fails when the bus was "DELETED"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" existed (not already "DELETED")
    And the bus was "DELETED"
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @delete_parameter_event_delivered @internal
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus fails when no event slot is available
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" existed (not already "DELETED")
    And the bus was "ACTIVE"
    And no event slot is available
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then the operation is rejected
