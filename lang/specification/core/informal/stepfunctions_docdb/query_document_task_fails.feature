@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - A Running "Step Functions" "Execution" Fails To Connect Because The "Documentdb" "Cluster" Is Stopped

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @query_document_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given a "step functions" "execution" was "RUNNING"
    And the "documentdb" "cluster" was "STOPPED"
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Then the "step functions" "execution" will be "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @guard @negative @query_document_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Then the operation is rejected

  @guard @negative @query_document_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped fails when the "documentdb" "cluster" was not "STOPPED"
    Given a "step functions" "execution" was "RUNNING"
    And the "documentdb" "cluster" was not "STOPPED"
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Then the operation is rejected
