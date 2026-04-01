@lambdaevents @generated
Feature: LambdaEvents - The "Lambda" "Function" Fails To Publish Because The Event Bus Has Been Deleted

  # Generated from FizzBee spec: lambda_events.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishedEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_bus_deleted
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "eventbridge" "bus" was "DELETED"
    When the "lambda" "function" fails to publish because the event bus has been deleted
    Then the "lambda" "invocation" will be "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @invocation_fails_bus_deleted @lifecycle
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to publish because the event bus has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_bus_deleted @lifecycle
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted fails when the "eventbridge" "bus" was not "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "eventbridge" "bus" was not "DELETED"
    When the "lambda" "function" fails to publish because the event bus has been deleted
    Then the operation is rejected
