@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - The "Neptune" "Cluster" Is Stopped

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @stop_cluster
  Scenario: the "neptune" "cluster" is stopped
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    When the "neptune" "cluster" is stopped
    Then the "neptune" "cluster" will be "STOPPED" and graph queries will be rejected
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "neptune" "cluster" it queried

  @guard @negative @stop_cluster
  Scenario: the "neptune" "cluster" is stopped fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When the "neptune" "cluster" is stopped
    Then the operation is rejected

  @guard @negative @stop_cluster @lifecycle
  Scenario: the "neptune" "cluster" is stopped fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When the "neptune" "cluster" is stopped
    Then the operation is rejected
