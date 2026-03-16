@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - A Running Execution Fails To Query Because The Neptune Cluster Is Stopped

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @query_graph_task_fails @internal
  Scenario: a running execution fails to query because the Neptune cluster is stopped
    Given an execution is "RUNNING"
    And the cluster is "STOPPED"
    When a running execution fails to query because the Neptune cluster is stopped
    Then the execution is "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @standard @negative @query_graph_task_fails @internal
  Scenario: a running execution fails to query because the Neptune cluster is stopped fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails to query because the Neptune cluster is stopped
    Then the operation is rejected

  @standard @negative @query_graph_task_fails @internal
  Scenario: a running execution fails to query because the Neptune cluster is stopped fails when the cluster is not "STOPPED"
    Given an execution is "RUNNING"
    And the cluster is not "STOPPED"
    When a running execution fails to query because the Neptune cluster is stopped
    Then the operation is rejected
