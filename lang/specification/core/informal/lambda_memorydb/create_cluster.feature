@lambdamemorydb @generated
Feature: LambdaMemorydb - A "Memorydb" "Cluster" Is Created

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "memorydb" "cluster" is created
    Given the "memorydb" "cluster" did not already exist
    When a "memorydb" "cluster" is created
    Then the "memorydb" "cluster" will be "AVAILABLE"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing record references a "memorydb" "cluster" that exists

  @guard @negative @create_cluster
  Scenario: a "memorydb" "cluster" is created fails when the "memorydb" "cluster" already existed
    Given the "memorydb" "cluster" already existed
    When a "memorydb" "cluster" is created
    Then the operation is rejected
