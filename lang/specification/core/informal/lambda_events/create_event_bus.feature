@lambdaevents @generated
Feature: LambdaEvents - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: lambda_events.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishedEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the bus does not already exist
    When an EventBridge event bus is created
    Then the bus is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @guard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the bus already exists
    Given the bus already exists
    When an EventBridge event bus is created
    Then the operation is rejected
