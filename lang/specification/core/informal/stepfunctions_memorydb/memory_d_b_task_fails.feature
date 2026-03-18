@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - A Running Execution Fails To Connect Because The Memorydb Cluster Is Updating

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @memory_d_b_task_fails @internal
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating
    Given an execution is "RUNNING"
    And the cluster is "UPDATING"
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then the execution is "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @standard @negative @memory_d_b_task_fails @internal
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then the operation is rejected

  @standard @negative @memory_d_b_task_fails @internal
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating fails when the cluster is not "UPDATING"
    Given an execution is "RUNNING"
    And the cluster is not "UPDATING"
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then the operation is rejected
