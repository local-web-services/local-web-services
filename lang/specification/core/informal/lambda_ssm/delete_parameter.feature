@lambdassm @generated
Feature: LambdaSsm - A Parameter Is Deleted From Ssm Parameter Store

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @delete_parameter
  Scenario: a parameter is deleted from "SSM" Parameter Store
    Given the parameter exists
    And the parameter "EXISTS"
    When a parameter is deleted from "SSM" Parameter Store
    Then the parameter is "DELETED" and will cause a ParameterNotFound error when read
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @standard @negative @delete_parameter
  Scenario: a parameter is deleted from "SSM" Parameter Store fails when the parameter does not exist
    Given the parameter does not exist
    When a parameter is deleted from "SSM" Parameter Store
    Then the operation is rejected

  @standard @negative @delete_parameter @lifecycle
  Scenario: a parameter is deleted from "SSM" Parameter Store fails when the parameter is already "DELETED"
    Given the parameter exists
    And the parameter is already "DELETED"
    When a parameter is deleted from "SSM" Parameter Store
    Then the operation is rejected
