@eventslambda @generated
Feature: EventsLambda - An Event Is Published To The Bus And Triggers An Asynchronous Lambda Invocation

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a function
    And the target function is "ACTIVE"
    And an invocation slot is available
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the invocation is "IN_PROGRESS"
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @standard @negative @put_event
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when the event bus does not exist
    Given the event bus does not exist
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when no "ENABLED" rule exists on the bus targeting a function
    Given the event bus exists
    And the event bus is "ACTIVE"
    And no "ENABLED" rule exists on the bus targeting a function
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when the target function is not "ACTIVE"
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a function
    And the target function is not "ACTIVE"
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected

  @standard @negative @internal @put_event @capacity
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when no invocation slot is available
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a function
    And the target function is "ACTIVE"
    And no invocation slot is available
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected
