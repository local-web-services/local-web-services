@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - A Running Execution Reads From The Available Elasticache Cluster And Succeeds

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @read_cache_task_succeeds @internal
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given an execution is "RUNNING"
    And the cluster is "AVAILABLE"
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @guard @negative @read_cache_task_succeeds @internal
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then the operation is rejected

  @guard @negative @read_cache_task_succeeds @internal
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds fails when the cluster is not "AVAILABLE"
    Given an execution is "RUNNING"
    And the cluster is not "AVAILABLE"
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then the operation is rejected
