@lambdamemorydb @generated
Feature: LambdaMemorydb - A "Memorydb" "Cluster" Update Begins

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_update_begins
  Scenario: a "memorydb" "cluster" update begins
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    When a "memorydb" "cluster" update begins
    Then the "memorydb" "cluster" will be "UPDATING" and write operations may fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @guard @negative @cluster_update_begins
  Scenario: a "memorydb" "cluster" update begins fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a "memorydb" "cluster" update begins
    Then the operation is rejected

  @guard @negative @cluster_update_begins @lifecycle
  Scenario: a "memorydb" "cluster" update begins fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "AVAILABLE"
    When a "memorydb" "cluster" update begins
    Then the operation is rejected
