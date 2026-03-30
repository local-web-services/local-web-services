@lambdasqs @generated
Feature: LambdaSqs - The Lambda Invocation Completes Successfully

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the invocation is "SUCCESS" and the "SQS" message is "DELETED"
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @guard @negative @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the operation is rejected
