@eventslambda @generated
Feature: EventsLambda - An "Eventbridge" "Rule" Is Created To Asynchronously Invoke A "Lambda" "Function" On Matching Events

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given the event bus existed
    And the event bus was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the rule did not already exist
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the rule will be "ENABLED" and will trigger the function when matching events are published
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the event bus did not exist
    Given the event bus did not exist
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the event bus was not "ACTIVE"
    Given the event bus existed
    And the event bus was not "ACTIVE"
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the "lambda" "function" did not exist
    Given the event bus existed
    And the event bus was "ACTIVE"
    And the "lambda" "function" did not exist
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the "lambda" "function" was not "ACTIVE"
    Given the event bus existed
    And the event bus was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events fails when the rule already existed
    Given the event bus existed
    And the event bus was "ACTIVE"
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the rule already existed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Then the operation is rejected
