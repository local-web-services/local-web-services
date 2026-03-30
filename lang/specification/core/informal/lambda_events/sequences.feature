@lambdaevents @generated
Feature: LambdaEvents - Action Sequences

  # Generated from FizzBee spec: lambda_events.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishedEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then the EventBridge event bus is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda function is invoked
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a Lambda function is deployed
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function is invoked
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then an EventBridge event bus is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then the EventBridge event bus is deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then the EventBridge event bus is deleted then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the EventBridge event bus has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to publish because the event bus has been deleted
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then a Lambda function is deployed then the Lambda function is invoked
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the EventBridge event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the Lambda function has been invoked
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the Lambda function has failed to publish because the event bus has been deleted
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a Lambda function is deployed then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a Lambda function has been deployed
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then the Lambda function fails to publish because the event bus has been deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an EventBridge event bus has been created
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function is invoked then a Lambda function is deployed
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the Lambda function has failed to publish because the event bus has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to publish because the event bus has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then an EventBridge event bus is created then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given an EventBridge event bus has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to publish because the event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then a Lambda function is deployed then an EventBridge event bus is created
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    Given a Lambda function has been deployed
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the EventBridge event bus is deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    Given the EventBridge event bus has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function is invoked then the Lambda function fails to publish because the event bus has been deleted
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    Given the Lambda function has been invoked
    When the Lambda function fails to publish because the event bus has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    Given the Lambda function has failed to publish because the event bus has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then a Lambda function is deployed then the EventBridge event bus is deleted
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    Given a Lambda function has been deployed
    When the EventBridge event bus is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then an EventBridge event bus is created then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    Given an EventBridge event bus has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the EventBridge event bus is deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    Given the EventBridge event bus has been deleted
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @sequence
  Scenario: the Lambda function fails to publish because the event bus has been deleted then the Lambda function publishes an event to the "ACTIVE" event bus and succeeds then an EventBridge event bus is created
    Given iid in inv_status
    Given the Lambda function has failed to publish because the event bus has been deleted
    Given the Lambda function has published an event to the "ACTIVE" event bus and succeeded
    When an EventBridge event bus is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists
