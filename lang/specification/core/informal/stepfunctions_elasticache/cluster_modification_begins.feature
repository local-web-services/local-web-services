@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - A Cluster Modification Begins

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modification_begins
  Scenario: a cluster modification begins
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    When a cluster modification begins
    Then the "elasticache" "cluster" will be "MODIFYING" and connections may be refused
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @guard @negative @cluster_modification_begins
  Scenario: a cluster modification begins fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When a cluster modification begins
    Then the operation is rejected

  @guard @negative @cluster_modification_begins @lifecycle
  Scenario: a cluster modification begins fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "AVAILABLE"
    When a cluster modification begins
    Then the operation is rejected
