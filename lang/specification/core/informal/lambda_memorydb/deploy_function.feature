@lambdamemorydb @generated
Feature: LambdaMemorydb - A "Lambda" "Function" Is Deployed

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @deploy_function
  Scenario: a "lambda" "function" is deployed
    Given the "lambda" "function" did not already exist
    When a "lambda" "function" is deployed
    Then the "lambda" "function" will be "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @guard @negative @deploy_function
  Scenario: a "lambda" "function" is deployed fails when the "lambda" "function" already existed
    Given the "lambda" "function" already existed
    When a "lambda" "function" is deployed
    Then the operation is rejected
