@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - A Running "Step Functions" "Execution" Connects To The Available Memorydb Cluster And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @memory_d_b_task_succeeds @internal
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "memorydb" "cluster" was "AVAILABLE"
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @guard @negative @memory_d_b_task_succeeds @internal
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then the operation is rejected

  @guard @negative @memory_d_b_task_succeeds @internal
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given a "step functions" "execution" was "RUNNING"
    And the "memorydb" "cluster" was not "AVAILABLE"
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then the operation is rejected
