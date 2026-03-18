@cognitoevents @generated
Feature: CognitoEvents - Eventbridge Publishing Is Enabled On The User Pool

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @enable_event_publishing
  Scenario: EventBridge publishing is enabled on the user pool
    Given the pool exists and is "ACTIVE"
    And the pool has no EventBridge configuration
    And the bus exists and is "ACTIVE"
    When EventBridge publishing is enabled on the user pool
    Then the pool will send user events to the bus
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @enable_event_publishing @lifecycle @internal
  Scenario: EventBridge publishing is enabled on the user pool fails when the pool does not exist or is not "ACTIVE"
    Given the pool does not exist or is not "ACTIVE"
    When EventBridge publishing is enabled on the user pool
    Then the operation is rejected

  @standard @negative @enable_event_publishing
  Scenario: EventBridge publishing is enabled on the user pool fails when the pool already has an EventBridge configuration
    Given the pool exists and is "ACTIVE"
    And the pool already has an EventBridge configuration
    When EventBridge publishing is enabled on the user pool
    Then the operation is rejected

  @standard @negative @enable_event_publishing
  Scenario: EventBridge publishing is enabled on the user pool fails when the bus does not exist or is not "ACTIVE"
    Given the pool exists and is "ACTIVE"
    And the pool has no EventBridge configuration
    And the bus does not exist or is not "ACTIVE"
    When EventBridge publishing is enabled on the user pool
    Then the operation is rejected
