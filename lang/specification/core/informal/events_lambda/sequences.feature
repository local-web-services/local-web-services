@eventslambda @generated
Feature: EventsLambda - Action Sequences

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda invocation completes successfully
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda invocation fails
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then an EventBridge event bus is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then a Lambda function is deployed
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then the Lambda invocation completes successfully
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then the Lambda invocation fails
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge event bus is created
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then a Lambda function is deployed
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation completes successfully
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation fails
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an EventBridge event bus is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an EventBridge event bus is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given a Lambda function has been deployed
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation completes successfully
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda invocation fails then a Lambda function is deployed
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an EventBridge event bus has been created
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then an EventBridge event bus is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has completed successfully
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then an EventBridge event bus is created then the Lambda invocation completes successfully
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    Given an EventBridge event bus has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then a Lambda function is deployed then the Lambda invocation fails
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge event bus is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then the Lambda invocation completes successfully then a Lambda function is deployed
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then the Lambda invocation fails then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given rid not in rule_status
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    Given the Lambda invocation has failed
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge event bus is created then the Lambda invocation fails
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    Given an EventBridge event bus has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then a Lambda function is deployed then an EventBridge event bus is created
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    Given a Lambda function has been deployed
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then a Lambda function is deployed
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation completes successfully then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    Given the Lambda invocation has completed successfully
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given bid in bus_status
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an EventBridge event bus is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an EventBridge event bus has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has been deployed
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an event is published to the bus and triggers an asynchronous Lambda invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an EventBridge event bus is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda invocation has failed
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an EventBridge event bus is created then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an EventBridge event bus has been created
    When an EventBridge rule is created to asynchronously invoke a Lambda function on matching events
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then an event is published to the bus and triggers an asynchronous Lambda invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has been deployed
    When an event is published to the bus and triggers an asynchronous Lambda invocation
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an EventBridge rule is created to asynchronously invoke a Lambda function on matching events then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an event is published to the bus and triggers an asynchronous Lambda invocation then an EventBridge event bus is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an event has been published to the bus and has triggered an asynchronous Lambda invocation
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus
