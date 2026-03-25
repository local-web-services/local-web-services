@rdsevents @generated
Feature: RdsEvents - Action Sequences

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "DB" instance finishes stopping
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the "DB" instance finishes stopping
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the "DB" instance finishes stopping
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then an EventBridge event bus is created
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the EventBridge event bus is deleted
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "DB" instance finishes stopping
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "DB" instance finishes stopping
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then an EventBridge event bus is created
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then the EventBridge event bus is deleted
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the EventBridge event bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "DB" instance finishes stopping
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "DB" instance finishes stopping then an EventBridge event bus is created
    Given dbid not in db_status
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "DB" instance finishes stopping
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "DB" instance finishes stopping
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the "DB" instance finishes stopping then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the "DB" instance finishes stopping
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the "DB" instance finishes stopping
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the "DB" instance finishes stopping then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the "DB" instance finishes stopping
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then an "RDS" "DB" instance is created and becomes "AVAILABLE" then the "DB" instance finishes stopping
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then an EventBridge event bus is created then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When an EventBridge event bus is created
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "DB" instance finishes stopping then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the "DB" instance finishes stopping
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an "RDS" "DB" instance is created and becomes "AVAILABLE" then an EventBridge event bus is created
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the EventBridge event bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "RDS" instance stops and delivers the state change event to the EventBridge bus then the "DB" instance finishes stopping
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When the "DB" instance finishes stopping
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted then the "DB" instance finishes stopping then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When the "DB" instance finishes stopping
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then an "RDS" "DB" instance is created and becomes "AVAILABLE" then the EventBridge event bus is deleted
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then an EventBridge event bus is created then the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When an EventBridge event bus is created
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then the EventBridge event bus is deleted then the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When the EventBridge event bus is deleted
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then the "RDS" instance stops and delivers the state change event to the EventBridge bus then an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the "DB" instance finishes stopping then the "RDS" instance stops but the state change event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given dbid in db_status
    When the "DB" instance finishes stopping
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists
