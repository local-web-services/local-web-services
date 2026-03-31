@eventslambda @generated
Feature: EventsLambda - Action Sequences

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: an EventBridge event bus is created then a "lambda" "function" is deployed
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda invocation completes successfully
    Given bid not in bus_status
    When an EventBridge event bus is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda invocation fails
    Given bid not in bus_status
    When an EventBridge event bus is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then an EventBridge event bus is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an EventBridge event bus is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then a "lambda" "function" is deployed
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the Lambda invocation completes successfully
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the Lambda invocation fails
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then a "lambda" "function" is deployed
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation completes successfully
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation fails
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given iid in inv_status
    When the Lambda invocation fails
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then a "lambda" "function" is deployed then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a "lambda" "function" is deployed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation completes successfully
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given bid not in bus_status
    When an EventBridge event bus is created
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda invocation fails then a "lambda" "function" is deployed
    Given bid not in bus_status
    When an EventBridge event bus is created
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then an EventBridge event bus is created then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an EventBridge event bus is created
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the Lambda invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation completes successfully then an EventBridge event bus is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an EventBridge event bus is created then the Lambda invocation completes successfully
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an EventBridge event bus is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then a "lambda" "function" is deployed then the Lambda invocation fails
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge event bus is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the Lambda invocation fails then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the Lambda invocation fails
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge event bus is created then the Lambda invocation fails
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When an EventBridge event bus is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then a "lambda" "function" is deployed then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When a "lambda" "function" is deployed
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then a "lambda" "function" is deployed
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation completes successfully then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When the Lambda invocation completes successfully
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given bid in bus_status
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then an EventBridge event bus is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an EventBridge event bus is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" is deployed then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then an EventBridge event bus is created then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given iid in inv_status
    When the Lambda invocation fails
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" is deployed then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus
