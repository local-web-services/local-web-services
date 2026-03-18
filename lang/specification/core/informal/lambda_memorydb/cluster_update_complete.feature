@lambdamemorydb @generated
Feature: LambdaMemorydb - The Memorydb Cluster Update Completes

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_update_complete
  Scenario: the MemoryDB cluster update completes
    Given the cluster is "UPDATING"
    When the MemoryDB cluster update completes
    Then the cluster is "AVAILABLE" again
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @standard @negative @cluster_update_complete @lifecycle @internal
  Scenario: the MemoryDB cluster update completes fails when the cluster is not "UPDATING"
    Given the cluster is not "UPDATING"
    When the MemoryDB cluster update completes
    Then the operation is rejected
