@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - A "Memorydb" "Cluster" Update Begins

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_update_begins
  Scenario: a "memorydb" "cluster" update begins
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was "AVAILABLE"
    When a "memorydb" "cluster" update begins
    Then the "memorydb" "cluster" will be "UPDATING" and connections may be refused
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @cluster_update_begins
  Scenario: a "memorydb" "cluster" update begins fails when the "memorydb" "cluster" did not exist
    Given the "memorydb" "cluster" did not exist
    When a "memorydb" "cluster" update begins
    Then the operation is rejected

  @guard @negative @cluster_update_begins @lifecycle
  Scenario: a "memorydb" "cluster" update begins fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given the "memorydb" "cluster" existed
    And the "memorydb" "cluster" was not "AVAILABLE"
    When a "memorydb" "cluster" update begins
    Then the operation is rejected
