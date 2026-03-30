@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - A Running Execution Connects To The Available Memorydb Cluster And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @memory_d_b_task_succeeds @internal
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given an execution is "RUNNING"
    And the cluster is "AVAILABLE"
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @memory_d_b_task_succeeds @internal
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then the operation is rejected

  @guard @negative @memory_d_b_task_succeeds @internal
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds fails when the cluster is not "AVAILABLE"
    Given an execution is "RUNNING"
    And the cluster is not "AVAILABLE"
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then the operation is rejected
