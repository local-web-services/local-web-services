@lambdaevents @generated
Feature: LambdaEvents - Action Sequences

  # Generated from FizzBee spec: lambda_events.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishedEventReferencesExistingBus

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the EventBridge event bus is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function is invoked
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Lambda function is deployed
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function is invoked
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an EventBridge event bus is created
    Given fid in func_status
    When the Lambda function is invoked
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the EventBridge event bus is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When an EventBridge event bus is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the EventBridge event bus is deleted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then an EventBridge event bus is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the EventBridge event bus is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed then the Lambda function is invoked
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then a Lambda function is deployed
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then the Lambda function is invoked
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function is invoked then a Lambda function is deployed
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function is invoked then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Lambda function is deployed then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Lambda function is deployed then the Lambda function is invoked
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then a Lambda function is deployed
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the Lambda function is invoked
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function is invoked then a Lambda function is deployed
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function is invoked then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then an EventBridge event bus is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the EventBridge event bus is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an EventBridge event bus is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When an EventBridge event bus is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the EventBridge event bus is deleted then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given fid in func_status
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When a Lambda function is deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When an EventBridge event bus is created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function is invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When an EventBridge event bus is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the EventBridge event bus is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists
