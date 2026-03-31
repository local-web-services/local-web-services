@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - A Running "Step Functions" "Execution" Queries The Available Neptune Cluster And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @query_graph_task_succeeds @internal
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "neptune" "cluster" was "AVAILABLE"
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @guard @negative @query_graph_task_succeeds @internal
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then the operation is rejected

  @guard @negative @query_graph_task_succeeds @internal
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds fails when the "neptune" "cluster" was not "AVAILABLE"
    Given a "step functions" "execution" was "RUNNING"
    And the "neptune" "cluster" was not "AVAILABLE"
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then the operation is rejected
