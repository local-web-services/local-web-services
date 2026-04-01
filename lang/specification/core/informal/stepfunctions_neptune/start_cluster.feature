@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - The "Neptune" "Cluster" Is Started

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @start_cluster
  Scenario: the "neptune" "cluster" is started
    Given the "neptune" "cluster" was "STOPPED"
    When the "neptune" "cluster" is started
    Then the "neptune" "cluster" will be "AVAILABLE" and ready to accept graph queries
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @guard @negative @start_cluster @lifecycle
  Scenario: the "neptune" "cluster" is started fails when the "neptune" "cluster" was not "STOPPED"
    Given the "neptune" "cluster" was not "STOPPED"
    When the "neptune" "cluster" is started
    Then the operation is rejected
