@eventslambda @generated
Feature: EventsLambda - Action Sequences

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "lambda" "function" is deployed
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" invocation completes successfully
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" invocation fails
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "bus" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an "eventbridge" "bus" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then a "lambda" "function" is deployed
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the "lambda" "function" invocation completes successfully
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the "lambda" "function" invocation fails
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then an "eventbridge" "bus" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then a "lambda" "function" is deployed
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then the "lambda" "function" invocation completes successfully
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then the "lambda" "function" invocation fails
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "eventbridge" "bus" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "eventbridge" "bus" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "lambda" "function" is deployed then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a "lambda" "function" is deployed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then the "lambda" "function" invocation completes successfully
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully then an "eventbridge" "bus" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an "eventbridge" "bus" is created then the "lambda" "function" invocation completes successfully
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an "eventbridge" "bus" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then an "eventbridge" "bus" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the "lambda" "function" invocation fails then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the "lambda" "function" invocation fails
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then an "eventbridge" "bus" is created then the "lambda" "function" invocation fails
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When an "eventbridge" "bus" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then a "lambda" "function" is deployed then an "eventbridge" "bus" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When a "lambda" "function" is deployed
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then a "lambda" "function" is deployed
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then the "lambda" "function" invocation completes successfully then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When the "lambda" "function" invocation completes successfully
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "eventbridge" "bus" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "eventbridge" "bus" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails then an "eventbridge" "bus" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation then an "eventbridge" "bus" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
