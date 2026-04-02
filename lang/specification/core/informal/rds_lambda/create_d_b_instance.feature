@rdslambda @generated
Feature: RdsLambda - An "Rds" "Db Instance" Is Created

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: an "rds" "DB instance" is created
    Given the "rds" "instance" did not already exist
    When an "rds" "DB instance" is created
    Then the "DB" instance will be "AVAILABLE" with no Lambda integration configured
    And every successful "lambda" "invocation" references an "rds" "DB instance" that exists
    And every successful "rds" "invocation" recorded which "lambda" "function" it invoked

  @guard @negative @create_d_b_instance
  Scenario: an "rds" "DB instance" is created fails when the "rds" "instance" already existed
    Given the "rds" "instance" already existed
    When an "rds" "DB instance" is created
    Then the operation is rejected
