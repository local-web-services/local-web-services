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
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @guard @negative @start_cluster @lifecycle
  Scenario: the "documentdb" "cluster" is started fails when the "documentdb" "cluster" was not "STOPPED"
    Given the "documentdb" "cluster" was not "STOPPED"
    When the "documentdb" "cluster" is started
    Then the operation is rejected
