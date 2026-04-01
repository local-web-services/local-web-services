@lambdamemorydb @generated
Feature: LambdaMemorydb - The "Lambda" "Function" Fails To Write Because The "Memorydb" "Cluster" Is Updating

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_cluster_updating @internal
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "memorydb" "cluster" was "UPDATING"
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Then the "lambda" "invocation" will be "FAILED" with a connection refused error
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing record references a "memorydb" "cluster" that exists

  @guard @negative @invocation_fails_cluster_updating @internal
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Then the operation is rejected

  @guard @negative @invocation_fails_cluster_updating @internal
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating fails when the "memorydb" "cluster" was not "UPDATING"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "memorydb" "cluster" was not "UPDATING"
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Then the operation is rejected
