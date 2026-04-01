@ssmevents @generated
Feature: SsmEvents - Action Sequences

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given pid not in param_status
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given pid not in param_status
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given pid not in param_status
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "eventbridge" "bus" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given pid not in param_status
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given pid not in param_status
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given pid in param_status
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given pid in param_status
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given pid in param_status
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given pid in param_status
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given pid not in param_status
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given pid not in param_status
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "eventbridge" "bus" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given pid not in param_status
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given pid not in param_status
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    Given pid not in param_status
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given pid not in param_status
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    Given pid in param_status
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given pid in param_status
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given pid in param_status
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created and "ssm" delivers a "CREATED" "eventbridge" "event" to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus" then a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "eventbridge" "bus" is deleted
    Given pid in param_status
    When a "ssm" "parameter" is deleted and "ssm" delivers a "DELETED" "eventbridge" "event" to the "eventbridge" "bus"
    When a "ssm" "parameter" is created but the "CREATED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references a "ssm" "parameter" that exists (in any state)
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists
