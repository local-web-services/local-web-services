@rdsevents @generated
Feature: RdsEvents - Action Sequences

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then an "eventbridge" "bus" is created
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then the "eventbridge" "bus" is deleted
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "DB instance" finishes stopping
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "rds" "DB instance" finishes stopping
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "rds" "DB instance" finishes stopping
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then an "eventbridge" "bus" is created
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "eventbridge" "bus" is deleted
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "rds" "DB instance" finishes stopping
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then an "eventbridge" "bus" is created
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then the "rds" "DB instance" finishes stopping
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then an "eventbridge" "bus" is created
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then the "eventbridge" "bus" is deleted
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then the "eventbridge" "bus" is deleted then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "eventbridge" "bus" is deleted
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then the "rds" "DB instance" finishes stopping
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "DB instance" finishes stopping then an "eventbridge" "bus" is created
    Given dbid not in db_status
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "DB instance" finishes stopping
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "rds" "DB instance" finishes stopping
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "rds" "DB instance" finishes stopping then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "rds" "DB instance" finishes stopping
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then the "rds" "DB instance" finishes stopping
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "rds" "instance" stops and delivers the state change event to the EventBridge bus then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "rds" "DB instance" finishes stopping then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "rds" "DB instance" finishes stopping
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then an "rds" "DB instance" is created and becomes "AVAILABLE" then the "rds" "DB instance" finishes stopping
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then an "eventbridge" "bus" is created then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When an "eventbridge" "bus" is created
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "rds" "DB instance" finishes stopping then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "rds" "DB instance" finishes stopping
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then an "rds" "DB instance" is created and becomes "AVAILABLE" then an "eventbridge" "bus" is created
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then the "rds" "instance" stops and delivers the state change event to the EventBridge bus then the "rds" "DB instance" finishes stopping
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When the "rds" "DB instance" finishes stopping
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then the "rds" "DB instance" finishes stopping then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When the "rds" "DB instance" finishes stopping
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then an "rds" "DB instance" is created and becomes "AVAILABLE" then the "eventbridge" "bus" is deleted
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    When the "eventbridge" "bus" is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then an "eventbridge" "bus" is created then the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When an "eventbridge" "bus" is created
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then the "eventbridge" "bus" is deleted then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When the "eventbridge" "bus" is deleted
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then the "rds" "instance" stops and delivers the state change event to the EventBridge bus then an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "rds" "DB instance" finishes stopping then the "rds" "instance" stops but the state change event delivery fails because the bus is deleted then an "eventbridge" "bus" is created
    Given dbid in db_status
    When the "rds" "DB instance" finishes stopping
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists
