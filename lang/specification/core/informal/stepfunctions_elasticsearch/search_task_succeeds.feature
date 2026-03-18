@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - A Running Execution Calls An Available Elasticsearch Domain And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @search_task_succeeds @internal
  Scenario: a running execution calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given an execution is "RUNNING"
    And the domain is "AVAILABLE"
    When a running execution calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @standard @negative @search_task_succeeds @internal
  Scenario: a running execution calls an "AVAILABLE" Elasticsearch domain and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Then the operation is rejected

  @standard @negative @search_task_succeeds @internal
  Scenario: a running execution calls an "AVAILABLE" Elasticsearch domain and the task succeeds fails when the domain is not "AVAILABLE"
    Given an execution is "RUNNING"
    And the domain is not "AVAILABLE"
    When a running execution calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Then the operation is rejected
