@lambdamemorydb @generated
Feature: LambdaMemorydb - A Memorydb Cluster Is Created

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a MemoryDB cluster is created
    Given the cluster does not already exist
    When a MemoryDB cluster is created
    Then the cluster is "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @standard @negative @create_cluster
  Scenario: a MemoryDB cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a MemoryDB cluster is created
    Then the operation is rejected
