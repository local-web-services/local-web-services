@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - A Running "Step Functions" "Execution" Fails To Connect Because The "Memorydb" "Cluster" Is Updating

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @memory_d_b_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given a "step functions" "execution" was "RUNNING"
    And the "memorydb" "cluster" was "UPDATING"
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Then the "step functions" "execution" will be "FAILED" with a connection error
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @guard @negative @memory_d_b_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Then the operation is rejected

  @guard @negative @memory_d_b_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating fails when the "memorydb" "cluster" was not "UPDATING"
    Given a "step functions" "execution" was "RUNNING"
    And the "memorydb" "cluster" was not "UPDATING"
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Then the operation is rejected
