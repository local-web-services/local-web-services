@eventslambda @generated
Feature: EventsLambda - An Eventbridge Rule Is Created To Asynchronously Invoke A Lambda Function On Matching Events

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the function exists
    And the function is "ACTIVE"
    And the rule does not already exist
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then the rule is "ENABLED" and will trigger the function when matching events are published
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events fails when the event bus does not exist
    Given the event bus does not exist
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then the operation is rejected

  @standard @negative @put_rule @lifecycle @internal
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then the operation is rejected

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events fails when the function does not exist
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the function does not exist
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then the operation is rejected

  @standard @negative @put_rule @lifecycle @internal
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events fails when the function is not "ACTIVE"
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the function exists
    And the function is not "ACTIVE"
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then the operation is rejected

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events fails when the rule already exists
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the function exists
    And the function is "ACTIVE"
    And the rule already exists
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then the operation is rejected
