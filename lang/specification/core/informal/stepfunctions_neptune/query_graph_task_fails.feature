@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - A Running "Step Functions" "Execution" Fails To Query Because The "Neptune" "Cluster" Is Stopped

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @query_graph_task_fails @internal
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given a "step functions" "execution" was "RUNNING"
    And the "neptune" "cluster" was "STOPPED"
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Then the "step functions" "execution" will be "FAILED" with a connection error
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "neptune" "cluster" it queried

  @guard @negative @query_graph_task_fails @internal
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Then the operation is rejected

  @guard @negative @query_graph_task_fails @internal
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped fails when the "neptune" "cluster" was not "STOPPED"
    Given a "step functions" "execution" was "RUNNING"
    And the "neptune" "cluster" was not "STOPPED"
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Then the operation is rejected
