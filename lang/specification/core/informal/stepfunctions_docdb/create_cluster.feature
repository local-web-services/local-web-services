@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - A "Documentdb" "Cluster" Is Created

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "documentdb" "cluster" is created
    Given the "documentdb" "cluster" did not already exist
    When a "documentdb" "cluster" is created
    Then the "documentdb" "cluster" will be "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @guard @negative @create_cluster
  Scenario: a "documentdb" "cluster" is created fails when the "documentdb" "cluster" already existed
    Given the "documentdb" "cluster" already existed
    When a "documentdb" "cluster" is created
    Then the operation is rejected
