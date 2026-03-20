@lambdamemorydb @generated
Feature: LambdaMemorydb - A Memorydb Cluster Update Begins

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_update_begins
  Scenario: a MemoryDB cluster update begins
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When a MemoryDB cluster update begins
    Then the cluster is "UPDATING" and write operations may fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @standard @negative @cluster_update_begins
  Scenario: a MemoryDB cluster update begins fails when the cluster does not exist
    Given the cluster does not exist
    When a MemoryDB cluster update begins
    Then the operation is rejected

  @standard @negative @cluster_update_begins @lifecycle
  Scenario: a MemoryDB cluster update begins fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a MemoryDB cluster update begins
    Then the operation is rejected
