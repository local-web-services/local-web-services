@lambdamemorydb @generated
Feature: LambdaMemorydb - The "Memorydb" "Cluster" Update Completes

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_update_complete
  Scenario: the "memorydb" "cluster" update completes
    Given the "memorydb" "cluster" was "UPDATING"
    When the "memorydb" "cluster" update completes
    Then the "memorydb" "cluster" will be "AVAILABLE" again
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @guard @negative @cluster_update_complete @lifecycle
  Scenario: the "memorydb" "cluster" update completes fails when the "memorydb" "cluster" was not "UPDATING"
    Given the "memorydb" "cluster" was not "UPDATING"
    When the "memorydb" "cluster" update completes
    Then the operation is rejected
