@eventslambda @generated
Feature: EventsLambda - An Event Is Published To The Bus And Triggers An Asynchronous Lambda Invocation

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation
    Given the event bus existed
    And the event bus was "ACTIVE"
    And an "ENABLED" rule existed on the bus targeting a function
    And the target function was "ACTIVE"
    And a "lambda" "invocation" slot is available
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the invocation will be "IN_PROGRESS"
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @guard @negative @put_event
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when the event bus did not exist
    Given the event bus did not exist
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when the event bus was not "ACTIVE"
    Given the event bus existed
    And the event bus was not "ACTIVE"
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when no "ENABLED" rule existed on the bus targeting a function
    Given the event bus existed
    And the event bus was "ACTIVE"
    And no "ENABLED" rule existed on the bus targeting a function
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when the target function was not "ACTIVE"
    Given the event bus existed
    And the event bus was "ACTIVE"
    And an "ENABLED" rule existed on the bus targeting a function
    And the target function was not "ACTIVE"
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected

  @guard @negative @put_event @capacity
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation fails when no invocation slot is available
    Given the event bus existed
    And the event bus was "ACTIVE"
    And an "ENABLED" rule existed on the bus targeting a function
    And the target function was "ACTIVE"
    And no invocation slot is available
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then the operation is rejected
