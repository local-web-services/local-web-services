@lambdaevents @generated
Feature: LambdaEvents - The Lambda Function Publishes An Event To The Active Event Bus And Succeeds

  # Generated from FizzBee spec: lambda_events.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishedEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @publish_event_task @internal
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Given an invocation is "IN_PROGRESS"
    And the bus is "ACTIVE"
    And an event slot is available
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then the event is "PUBLISHED" and the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @standard @negative @publish_event_task @internal
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then the operation is rejected

  @standard @negative @publish_event_task @internal
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds fails when the bus does not exist or is "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the bus does not exist or is "DELETED"
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then the operation is rejected

  @standard @negative @publish_event_task @internal
  Scenario: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds fails when no event slot is available
    Given an invocation is "IN_PROGRESS"
    And the bus is "ACTIVE"
    And no event slot is available
    When the Lambda function publishes an event to the "ACTIVE" event bus and succeeds
    Then the operation is rejected
