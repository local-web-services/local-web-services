@lambdaopensearch @generated
Feature: LambdaOpensearch - The Lambda Invocation Completes Successfully

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the operation is rejected
