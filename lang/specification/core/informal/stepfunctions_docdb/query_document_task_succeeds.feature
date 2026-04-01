@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - A Running "Step Functions" "Execution" Connects To The "Documentdb" "Cluster" That Was "Available" And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @query_document_task_succeeds @internal
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "documentdb" "cluster" was "AVAILABLE"
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @guard @negative @query_document_task_succeeds @internal
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Then the operation is rejected

  @guard @negative @query_document_task_succeeds @internal
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given a "step functions" "execution" was "RUNNING"
    And the "documentdb" "cluster" was not "AVAILABLE"
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Then the operation is rejected
