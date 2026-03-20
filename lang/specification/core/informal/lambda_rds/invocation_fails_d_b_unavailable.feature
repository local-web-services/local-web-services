@lambdards @generated
Feature: LambdaRds - The Lambda Function Fails To Connect Because The Database Is Failing Over

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_d_b_unavailable
  Scenario: the Lambda function fails to connect because the database is failing over
    Given an invocation is "IN_PROGRESS"
    And the database instance is "FAILING_OVER"
    When the Lambda function fails to connect because the database is failing over
    Then the invocation is "FAILED" with a connection error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @standard @negative @invocation_fails_d_b_unavailable @lifecycle
  Scenario: the Lambda function fails to connect because the database is failing over fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to connect because the database is failing over
    Then the operation is rejected

  @standard @negative @invocation_fails_d_b_unavailable @lifecycle
  Scenario: the Lambda function fails to connect because the database is failing over fails when the database instance is not "FAILING_OVER"
    Given an invocation is "IN_PROGRESS"
    And the database instance is not "FAILING_OVER"
    When the Lambda function fails to connect because the database is failing over
    Then the operation is rejected
