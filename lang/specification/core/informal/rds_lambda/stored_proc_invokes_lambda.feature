@rdslambda @generated
Feature: RdsLambda - A Rds Stored Procedure Invokes The "Lambda" "Function" And Succeeds

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @stored_proc_invokes_lambda
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has a "lambda" "function" integration configured
    And the "lambda" "function" was "ACTIVE"
    And a "lambda" "invocation" slot is available
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the "lambda" "invocation" will be "SUCCESS"
    And every successful "lambda" "invocation" references an "rds" "DB instance" that exists
    And every successful "rds" "invocation" recorded which "lambda" "function" it invoked

  @guard @negative @stored_proc_invokes_lambda @lifecycle
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" was not "AVAILABLE"
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the operation is rejected

  @guard @negative @stored_proc_invokes_lambda
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds fails when the "rds" "instance" has no "lambda" "function" integration configured
    Given the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has no "lambda" "function" integration configured
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the operation is rejected

  @guard @negative @stored_proc_invokes_lambda @lifecycle
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds fails when the "lambda" "function" was not "ACTIVE"
    Given the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has a "lambda" "function" integration configured
    And the "lambda" "function" was not "ACTIVE"
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the operation is rejected

  @guard @negative @stored_proc_invokes_lambda @capacity
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds fails when no "lambda" "invocation" "slot" was "available"
    Given the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has a "lambda" "function" integration configured
    And the "lambda" "function" was "ACTIVE"
    And no "lambda" "invocation" "slot" was "available"
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Then the operation is rejected
