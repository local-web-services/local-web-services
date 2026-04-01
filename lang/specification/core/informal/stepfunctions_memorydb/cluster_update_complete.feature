@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - The "Memorydb" "Cluster" Update Completes

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_update_complete @internal
  Scenario: the "memorydb" "cluster" update completes
    Given the "memorydb" "cluster" was "UPDATING"
    When the "memorydb" "cluster" update completes
    Then the "memorydb" "cluster" will be "AVAILABLE" again
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @cluster_update_complete @internal
  Scenario: the "memorydb" "cluster" update completes fails when the "memorydb" "cluster" was not "UPDATING"
    Given the "memorydb" "cluster" was not "UPDATING"
    When the "memorydb" "cluster" update completes
    Then the operation is rejected
