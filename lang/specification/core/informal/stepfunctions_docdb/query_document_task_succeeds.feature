@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - A Running Execution Connects To The Available Documentdb Cluster And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @query_document_task_succeeds @internal
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given an execution is "RUNNING"
    And the cluster is "AVAILABLE"
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @standard @negative @query_document_task_succeeds @internal
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Then the operation is rejected

  @standard @negative @query_document_task_succeeds @internal
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds fails when the cluster is not "AVAILABLE"
    Given an execution is "RUNNING"
    And the cluster is not "AVAILABLE"
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Then the operation is rejected
