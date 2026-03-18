@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - A Running Execution Fails To Connect Because The Cluster Is Being Modified

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @read_cache_task_fails @internal
  Scenario: a running execution fails to connect because the cluster is being modified
    Given an execution is "RUNNING"
    And the cluster is "MODIFYING"
    When a running execution fails to connect because the cluster is being modified
    Then the execution is "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @standard @negative @read_cache_task_fails @internal
  Scenario: a running execution fails to connect because the cluster is being modified fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails to connect because the cluster is being modified
    Then the operation is rejected

  @standard @negative @read_cache_task_fails @internal
  Scenario: a running execution fails to connect because the cluster is being modified fails when the cluster is not "MODIFYING"
    Given an execution is "RUNNING"
    And the cluster is not "MODIFYING"
    When a running execution fails to connect because the cluster is being modified
    Then the operation is rejected
