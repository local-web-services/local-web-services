@ssmevents @generated
Feature: SsmEvents - Action Sequences

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created
    Given pid not in param_status
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given pid not in param_status
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given pid not in param_status
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given pid not in param_status
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given pid not in param_status
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given pid not in param_status
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given pid not in param_status
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given pid not in param_status
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then an EventBridge event bus is created
    Given pid in param_status
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given pid in param_status
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given pid in param_status
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given pid in param_status
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the EventBridge event bus has been deleted
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a parameter is created but the "CREATED" event delivery fails because the bus is deleted then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an EventBridge event bus has been created
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a parameter is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given pid not in param_status
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    Given an EventBridge event bus has been created
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given pid not in param_status
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then a parameter is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given pid not in param_status
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given pid not in param_status
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given pid not in param_status
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given pid not in param_status
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    Given the EventBridge event bus has been deleted
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Given pid not in param_status
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    When a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is created but the "CREATED" event delivery fails because the bus is deleted then a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then an EventBridge event bus is created
    Given pid not in param_status
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then an EventBridge event bus is created then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Given pid in param_status
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    Given an EventBridge event bus has been created
    When a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then the EventBridge event bus is deleted then a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Given pid in param_status
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    Given the EventBridge event bus has been deleted
    When a parameter is created but the "CREATED" event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus then an EventBridge event bus is created
    Given pid in param_status
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    Given a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus then a parameter is created but the "CREATED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given pid in param_status
    Given a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus
    Given a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists
