@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - A Running Execution Fails To Connect Because The Documentdb Cluster Is Stopped

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @query_document_task_fails @internal
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped
    Given an execution is "RUNNING"
    And the cluster is "STOPPED"
    When a running execution fails to connect because the DocumentDB cluster is stopped
    Then the execution is "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @standard @negative @query_document_task_fails @internal
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails to connect because the DocumentDB cluster is stopped
    Then the operation is rejected

  @standard @negative @query_document_task_fails @internal
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped fails when the cluster is not "STOPPED"
    Given an execution is "RUNNING"
    And the cluster is not "STOPPED"
    When a running execution fails to connect because the DocumentDB cluster is stopped
    Then the operation is rejected
