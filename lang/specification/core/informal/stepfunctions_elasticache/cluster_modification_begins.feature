@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - An "Elasticache" "Cluster" Modification Begins

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modification_begins
  Scenario: an "elasticache" "cluster" modification begins
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    When an "elasticache" "cluster" modification begins
    Then the "elasticache" "cluster" will be "MODIFYING" and connections may be refused
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @guard @negative @cluster_modification_begins
  Scenario: an "elasticache" "cluster" modification begins fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When an "elasticache" "cluster" modification begins
    Then the operation is rejected

  @guard @negative @cluster_modification_begins @lifecycle
  Scenario: an "elasticache" "cluster" modification begins fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "AVAILABLE"
    When an "elasticache" "cluster" modification begins
    Then the operation is rejected
