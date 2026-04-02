@lambdassm @generated
Feature: LambdaSsm - A "Ssm" "Parameter" Is Deleted

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @delete_parameter
  Scenario: a "ssm" "parameter" is deleted
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" existed
    When a "ssm" "parameter" is deleted
    Then the "ssm" "parameter" will be deleted and will cause a ParameterNotFound error when read
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @guard @negative @delete_parameter
  Scenario: a "ssm" "parameter" is deleted fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When a "ssm" "parameter" is deleted
    Then the operation is rejected

  @guard @negative @delete_parameter @lifecycle
  Scenario: a "ssm" "parameter" is deleted fails when the "ssm" "parameter" is already "DELETED"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" is already "DELETED"
    When a "ssm" "parameter" is deleted
    Then the operation is rejected
