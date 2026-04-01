@eventslambda @generated
Feature: EventsLambda - An "Eventbridge" "Rule" Is Created To Asynchronously Invoke A "Lambda" "Function" On Matching Events

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "eventbridge" "rule" did not already exist
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the "eventbridge" "rule" will be "ENABLED" and will trigger the "lambda" "function" when matching events are published
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the "lambda" "function" did not exist
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "lambda" "function" did not exist
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the "lambda" "function" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the "eventbridge" "rule" already existed
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "eventbridge" "rule" already existed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected
