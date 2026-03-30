@rdsevents @generated
Feature: RdsEvents - Action Sequences

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "DB" instance finishes stopping
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "DB" instance finishes stopping
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "DB" instance finishes stopping
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then an EventBridge event bus is created
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the EventBridge event bus is deleted
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "DB" instance finishes stopping
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "DB" instance finishes stopping
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then an EventBridge event bus is created
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then the EventBridge event bus is deleted
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the EventBridge event bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    Given the EventBridge event bus has been deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "DB" instance finishes stopping
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "DB" instance finishes stopping then an EventBridge event bus is created
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    Given the "DB" instance has finished stopping
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the EventBridge event bus has been deleted
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "DB" instance finishes stopping
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the "DB" instance finishes stopping then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the "DB" instance has finished stopping
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the "DB" instance finishes stopping
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an EventBridge event bus has been created
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the "DB" instance finishes stopping then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the "DB" instance has finished stopping
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "DB" instance finishes stopping
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then an EventBridge event bus is created then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    Given an EventBridge event bus has been created
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "DB" instance finishes stopping then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    Given the "DB" instance has finished stopping
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the EventBridge event bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    Given the EventBridge event bus has been deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "DB" instance finishes stopping
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When the "DB" instance finishes stopping
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "DB" instance finishes stopping then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    Given the "DB" instance has finished stopping
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then an "RDS" "DB" instance is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    Given an "RDS" "DB" instance has been created and has become "AVAILABLE"
    When the EventBridge event bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then an EventBridge event bus is created then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    Given an EventBridge event bus has been created
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then the EventBridge event bus is deleted then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    Given the EventBridge event bus has been deleted
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then the "RDS" instance stops and delivers the state change event to the EventBridge bus then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    Given the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the "DB" instance finishes stopping then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given dbid in db_status
    Given the "DB" instance has finished stopping
    Given the "RDS" instance has stopped but the state change event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists
