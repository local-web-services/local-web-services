@eventslambda @generated
Feature: EventsLambda - An "Eventbridge" "Event" Is Published To The "Eventbridge" "Bus" And Triggers An Asynchronous "Lambda" "Function" Invocation

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "lambda" "function"
    And the target "lambda" "function" was "ACTIVE"
    And a "lambda" "invocation" slot is available
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Then the "lambda" "invocation" will be "IN_PROGRESS"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @guard @negative @put_event
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation fails when no "ENABLED" rule existed on the bus targeting a function
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And no "ENABLED" rule existed on the bus targeting a function
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation fails when the target "lambda" "function" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "lambda" "function"
    And the target "lambda" "function" was not "ACTIVE"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Then the operation is rejected

  @guard @negative @put_event @capacity
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation fails when no "lambda" "invocation" "slot" was "available"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "lambda" "function"
    And the target "lambda" "function" was "ACTIVE"
    And no "lambda" "invocation" "slot" was "available"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Then the operation is rejected
