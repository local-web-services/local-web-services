@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - The Neptune Cluster Is Started

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @start_cluster
  Scenario: the Neptune cluster is started
    Given the cluster is "STOPPED"
    When the Neptune cluster is started
    Then the cluster is "AVAILABLE" and ready to accept graph queries
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @standard @negative @start_cluster @lifecycle @internal
  Scenario: the Neptune cluster is started fails when the cluster is not "STOPPED"
    Given the cluster is not "STOPPED"
    When the Neptune cluster is started
    Then the operation is rejected
