@lambdaevents @generated
Feature: LambdaEvents - The Lambda Function Fails To Publish Because The Event Bus Has Been Deleted

  # Generated from FizzBee spec: lambda_events.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishedEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_bus_deleted
  Scenario: the Lambda function fails to publish because the event bus has been deleted
    Given an invocation is "IN_PROGRESS"
    And the bus is "DELETED"
    When the Lambda function fails to publish because the event bus has been deleted
    Then the invocation is "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "PUBLISHED" event references a bus that exists

  @guard @negative @invocation_fails_bus_deleted @lifecycle
  Scenario: the Lambda function fails to publish because the event bus has been deleted fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to publish because the event bus has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_bus_deleted @lifecycle
  Scenario: the Lambda function fails to publish because the event bus has been deleted fails when the bus is not "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the bus is not "DELETED"
    When the Lambda function fails to publish because the event bus has been deleted
    Then the operation is rejected
