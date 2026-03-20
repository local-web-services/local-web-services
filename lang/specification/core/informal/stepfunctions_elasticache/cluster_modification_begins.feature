@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - A Cluster Modification Begins

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modification_begins
  Scenario: a cluster modification begins
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When a cluster modification begins
    Then the cluster is "MODIFYING" and connections may be refused
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @standard @negative @cluster_modification_begins
  Scenario: a cluster modification begins fails when the cluster does not exist
    Given the cluster does not exist
    When a cluster modification begins
    Then the operation is rejected

  @standard @negative @cluster_modification_begins @lifecycle
  Scenario: a cluster modification begins fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a cluster modification begins
    Then the operation is rejected
