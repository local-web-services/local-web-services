@rdslambda @generated
Feature: RdsLambda - An Rds Stored Procedure Invokes The Lambda Function And Succeeds

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @stored_proc_invokes_lambda
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds
    Given the "DB" instance is "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the Lambda function is "ACTIVE"
    And an invocation slot is available
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then the invocation is "SUCCESS"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @standard @negative @stored_proc_invokes_lambda @lifecycle @internal
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds fails when the "DB" instance is not "AVAILABLE"
    Given the "DB" instance is not "AVAILABLE"
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then the operation is rejected

  @standard @negative @stored_proc_invokes_lambda
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds fails when the "DB" instance has no Lambda integration configured
    Given the "DB" instance is "AVAILABLE"
    And the "DB" instance has no Lambda integration configured
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then the operation is rejected

  @standard @negative @stored_proc_invokes_lambda @lifecycle @internal
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds fails when the Lambda function is not "ACTIVE"
    Given the "DB" instance is "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the Lambda function is not "ACTIVE"
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then the operation is rejected

  @standard @negative @stored_proc_invokes_lambda @capacity @internal
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds fails when no invocation slot is available
    Given the "DB" instance is "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the Lambda function is "ACTIVE"
    And no invocation slot is available
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then the operation is rejected
