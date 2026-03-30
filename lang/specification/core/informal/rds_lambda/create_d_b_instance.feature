@rdslambda @generated
Feature: RdsLambda - An Rds Db Instance Is Created

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: an "RDS" "DB" instance is created
    Given the "DB" instance does not already exist
    When an "RDS" "DB" instance is created
    Then the "DB" instance is "AVAILABLE" with no Lambda integration configured
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @guard @negative @create_d_b_instance
  Scenario: an "RDS" "DB" instance is created fails when the "DB" instance already exists
    Given the "DB" instance already exists
    When an "RDS" "DB" instance is created
    Then the operation is rejected
