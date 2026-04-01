@eventslambda @generated
Feature: EventsLambda - The Lambda Invocation Fails

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails
    Then the invocation will be "FAILED"
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @guard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails
    Then the operation is rejected
