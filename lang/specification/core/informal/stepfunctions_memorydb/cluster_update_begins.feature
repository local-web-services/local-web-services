@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - A Memorydb Cluster Update Begins

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_update_begins
  Scenario: a MemoryDB cluster update begins
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When a MemoryDB cluster update begins
    Then the cluster is "UPDATING" and connections may be refused
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @standard @negative @cluster_update_begins
  Scenario: a MemoryDB cluster update begins fails when the cluster does not exist
    Given the cluster does not exist
    When a MemoryDB cluster update begins
    Then the operation is rejected

  @standard @negative @cluster_update_begins @lifecycle @internal
  Scenario: a MemoryDB cluster update begins fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a MemoryDB cluster update begins
    Then the operation is rejected
