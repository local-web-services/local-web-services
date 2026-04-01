@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - A "Memorydb" "Cluster" Is Created

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "memorydb" "cluster" is created
    Given the "memorydb" "cluster" did not already exist
    When a "memorydb" "cluster" is created
    Then the "memorydb" "cluster" will be "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @create_cluster
  Scenario: a "memorydb" "cluster" is created fails when the "memorydb" "cluster" already existed
    Given the "memorydb" "cluster" already existed
    When a "memorydb" "cluster" is created
    Then the operation is rejected
