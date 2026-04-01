@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - A "Neptune" "Cluster" Is Created

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "neptune" "cluster" is created
    Given the "neptune" "cluster" did not already exist
    When a "neptune" "cluster" is created
    Then the "neptune" "cluster" will be "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @guard @negative @create_cluster
  Scenario: a "neptune" "cluster" is created fails when the "neptune" "cluster" already existed
    Given the "neptune" "cluster" already existed
    When a "neptune" "cluster" is created
    Then the operation is rejected
