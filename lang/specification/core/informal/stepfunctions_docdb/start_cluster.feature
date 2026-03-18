@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - The Documentdb Cluster Is Started

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @start_cluster
  Scenario: the DocumentDB cluster is started
    Given the cluster is "STOPPED"
    When the DocumentDB cluster is started
    Then the cluster is "AVAILABLE" and ready to accept connections
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @standard @negative @start_cluster @lifecycle @internal
  Scenario: the DocumentDB cluster is started fails when the cluster is not "STOPPED"
    Given the cluster is not "STOPPED"
    When the DocumentDB cluster is started
    Then the operation is rejected
