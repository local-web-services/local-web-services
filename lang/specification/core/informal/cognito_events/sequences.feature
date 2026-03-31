@cognitoevents @generated
Feature: CognitoEvents - Action Sequences

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "cognito" "user pool" is created then an EventBridge event bus is created
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then the EventBridge event bus is deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "cognito" "user pool" is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "cognito" "user pool" is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user pool" is created
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then an EventBridge event bus is created
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then the EventBridge event bus is deleted
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then the EventBridge event bus is deleted then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the EventBridge event bus is deleted
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "cognito" "user pool" is created then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "cognito" "user pool" is created
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then a "cognito" "user pool" is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "cognito" "user pool" is created then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "cognito" "user pool" is created
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user pool" is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user pool" is created then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user pool" is created
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then an EventBridge event bus is created then a "cognito" "user pool" is created
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When an EventBridge event bus is created
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then a "cognito" "user pool" is created then an EventBridge event bus is created
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When a "cognito" "user pool" is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then a "cognito" "user pool" is created then the EventBridge event bus is deleted
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When a "cognito" "user pool" is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created then EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then EventBridge publishing was "ENABLED" on the "cognito" "user" pool then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing was "ENABLED" on the "cognito" "user" pool
    When a "cognito" "user pool" is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists

  @sequence
  Scenario: a "cognito" "user" action occurs but event delivery fails because the bus has been deleted then a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given pid in pool_status
    When a "cognito" "user" action occurs but event delivery fails because the bus has been deleted
    When a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a "cognito" "user pool" that exists
    And every "DELIVERED" event references a bus that exists
