@rdslambda @generated
Feature: RdsLambda - A Rds Stored Procedure Invokes The "Lambda" "Function" And Succeeds

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @stored_proc_invokes_lambda
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given the "DB" instance was "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the "lambda" "function" was "ACTIVE"
    And a "lambda" "invocation" slot is available
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the invocation will be "SUCCESS"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @guard @negative @stored_proc_invokes_lambda @lifecycle
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds fails when the "DB" instance was not "AVAILABLE"
    Given the "DB" instance was not "AVAILABLE"
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the operation is rejected

  @guard @negative @stored_proc_invokes_lambda
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds fails when the "DB" instance has no Lambda integration configured
    Given the "DB" instance was "AVAILABLE"
    And the "DB" instance has no Lambda integration configured
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the operation is rejected

  @guard @negative @stored_proc_invokes_lambda @lifecycle
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds fails when the "lambda" "function" was not "ACTIVE"
    Given the "DB" instance was "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the "lambda" "function" was not "ACTIVE"
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the operation is rejected

  @guard @negative @stored_proc_invokes_lambda @capacity
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds fails when no invocation slot is available
    Given the "DB" instance was "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the "lambda" "function" was "ACTIVE"
    And no invocation slot is available
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the operation is rejected
