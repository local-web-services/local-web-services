@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - The Memorydb Cluster Update Completes

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_update_complete @internal
  Scenario: the MemoryDB cluster update completes
    Given the cluster is "UPDATING"
    When the MemoryDB cluster update completes
    Then the cluster is "AVAILABLE" again
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @cluster_update_complete @internal
  Scenario: the MemoryDB cluster update completes fails when the cluster is not "UPDATING"
    Given the cluster is not "UPDATING"
    When the MemoryDB cluster update completes
    Then the operation is rejected
