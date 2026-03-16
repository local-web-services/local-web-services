@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - A Neptune Cluster Is Created

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a Neptune cluster is created
    Given the cluster does not already exist
    When a Neptune cluster is created
    Then the cluster is "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @standard @negative @create_cluster
  Scenario: a Neptune cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a Neptune cluster is created
    Then the operation is rejected
