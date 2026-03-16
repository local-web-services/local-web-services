@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - The Documentdb Cluster Is Stopped

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @minimal @happy @stop_cluster
  Scenario: the DocumentDB cluster is stopped
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When the DocumentDB cluster is stopped
    Then the cluster is "STOPPED" and connections will be rejected
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @standard @negative @stop_cluster
  Scenario: the DocumentDB cluster is stopped fails when the cluster does not exist
    Given the cluster does not exist
    When the DocumentDB cluster is stopped
    Then the operation is rejected

  @standard @negative @stop_cluster @lifecycle
  Scenario: the DocumentDB cluster is stopped fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When the DocumentDB cluster is stopped
    Then the operation is rejected
