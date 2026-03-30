@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - A Running Execution Calls An Active Opensearch Domain And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @search_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given an execution is "RUNNING"
    And the domain is "ACTIVE"
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @search_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then the operation is rejected

  @guard @negative @search_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds fails when the domain is not "ACTIVE"
    Given an execution is "RUNNING"
    And the domain is not "ACTIVE"
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then the operation is rejected
