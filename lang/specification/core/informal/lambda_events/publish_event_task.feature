@lambdaevents @generated
Feature: LambdaEvents - The "Lambda" "Function" Publishes An Event To The Active Event Bus And Succeeds

  # Generated from FizzBee spec: lambda_events.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishedEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @publish_event_task @internal
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the bus was "ACTIVE"
    And an event slot is available
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Then the event will be "PUBLISHED" and the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @guard @negative @publish_event_task @internal
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Then the operation is rejected

  @guard @negative @publish_event_task @internal
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds fails when the bus did not exist or was "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the bus did not exist or was "DELETED"
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Then the operation is rejected

  @guard @negative @publish_event_task @internal
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds fails when no event slot is available
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the bus was "ACTIVE"
    And no event slot is available
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Then the operation is rejected
