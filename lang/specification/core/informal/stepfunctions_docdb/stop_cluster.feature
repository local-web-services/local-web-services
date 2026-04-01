@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - The "Documentdb" "Cluster" Is Stopped

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @stop_cluster
  Scenario: the "documentdb" "cluster" is stopped
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    When the "documentdb" "cluster" is stopped
    Then the "documentdb" "cluster" will be "STOPPED" and connections will be rejected
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @stop_cluster
  Scenario: the "documentdb" "cluster" is stopped fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "cluster" did not exist
    When the "documentdb" "cluster" is stopped
    Then the operation is rejected

  @guard @negative @stop_cluster @lifecycle
  Scenario: the "documentdb" "cluster" is stopped fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "AVAILABLE"
    When the "documentdb" "cluster" is stopped
    Then the operation is rejected
