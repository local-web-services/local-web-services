@lambdassm @generated
Feature: LambdaSsm - The Lambda Function Reads An Existing Parameter And Completes Successfully

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda function reads an existing parameter and completes successfully
    Given an invocation is "IN_PROGRESS"
    And the parameter "EXISTS"
    When the Lambda function reads an existing parameter and completes successfully
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function reads an existing parameter and completes successfully fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function reads an existing parameter and completes successfully
    Then the operation is rejected

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function reads an existing parameter and completes successfully fails when the parameter does not exist or is "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the parameter does not exist or is "DELETED"
    When the Lambda function reads an existing parameter and completes successfully
    Then the operation is rejected
