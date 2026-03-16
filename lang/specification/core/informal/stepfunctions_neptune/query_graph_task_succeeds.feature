@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - A Running Execution Queries The Available Neptune Cluster And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @query_graph_task_succeeds @internal
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given an execution is "RUNNING"
    And the cluster is "AVAILABLE"
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @standard @negative @query_graph_task_succeeds @internal
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then the operation is rejected

  @standard @negative @query_graph_task_succeeds @internal
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds fails when the cluster is not "AVAILABLE"
    Given an execution is "RUNNING"
    And the cluster is not "AVAILABLE"
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then the operation is rejected
