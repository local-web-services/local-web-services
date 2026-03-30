@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - A Memorydb Cluster Is Created

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a MemoryDB cluster is created
    Given the cluster does not already exist
    When a MemoryDB cluster is created
    Then the cluster is "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @create_cluster
  Scenario: a MemoryDB cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a MemoryDB cluster is created
    Then the operation is rejected
