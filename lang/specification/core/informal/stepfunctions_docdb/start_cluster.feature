@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - The "Documentdb" "Cluster" Is Started

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @start_cluster
  Scenario: the "documentdb" "cluster" is started
    Given the "documentdb" "cluster" was "STOPPED"
    When the "documentdb" "cluster" is started
    Then the "documentdb" "cluster" will be "AVAILABLE" and ready to accept connections
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @start_cluster @lifecycle
  Scenario: the "documentdb" "cluster" is started fails when the "documentdb" "cluster" was not "STOPPED"
    Given the "documentdb" "cluster" was not "STOPPED"
    When the "documentdb" "cluster" is started
    Then the operation is rejected
