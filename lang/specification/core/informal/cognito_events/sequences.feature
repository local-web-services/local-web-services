@cognitoevents @generated
Feature: CognitoEvents - Action Sequences

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an EventBridge event bus is created
    Given pid not in pool_status
    When a Cognito user pool is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the EventBridge event bus is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then EventBridge publishing is enabled on the user pool
    Given pid not in pool_status
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Cognito user pool is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then EventBridge publishing is enabled on the user pool
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Cognito user pool is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a Cognito user pool is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then an EventBridge event bus is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an EventBridge event bus is created then EventBridge publishing is enabled on the user pool
    Given pid not in pool_status
    When a Cognito user pool is created
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid not in pool_status
    When a Cognito user pool is created
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given pid not in pool_status
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool
    Given pid not in pool_status
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid not in pool_status
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then EventBridge publishing is enabled on the user pool then an EventBridge event bus is created
    Given pid not in pool_status
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid not in pool_status
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid not in pool_status
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Cognito user pool is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Cognito user pool is created then EventBridge publishing is enabled on the user pool
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a Cognito user pool is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then EventBridge publishing is enabled on the user pool then a Cognito user pool is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Cognito user pool is created then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Cognito user pool is created then EventBridge publishing is enabled on the user pool
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a Cognito user pool is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then EventBridge publishing is enabled on the user pool
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool then a Cognito user pool is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a Cognito user pool is created then an EventBridge event bus is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a Cognito user pool is created then the EventBridge event bus is deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then an EventBridge event bus is created then a Cognito user pool is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted then a Cognito user pool is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool then a user action occurs but event delivery fails because the bus has been deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    When a user action occurs but event delivery fails because the bus has been deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a Cognito user pool is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a Cognito user pool is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then an EventBridge event bus is created then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When an EventBridge event bus is created
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then the EventBridge event bus is deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When the EventBridge event bus is deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then EventBridge publishing is enabled on the user pool then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When EventBridge publishing is enabled on the user pool
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then a Cognito user pool is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When a Cognito user pool is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then an EventBridge event bus is created
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When an EventBridge event bus is created
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then the EventBridge event bus is deleted
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a user action occurs but event delivery fails because the bus has been deleted then a user action occurs in the pool and Cognito delivers the event to the EventBridge bus then EventBridge publishing is enabled on the user pool
    Given pid in pool_status
    When a user action occurs but event delivery fails because the bus has been deleted
    When a user action occurs in the pool and Cognito delivers the event to the EventBridge bus
    When EventBridge publishing is enabled on the user pool
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists
