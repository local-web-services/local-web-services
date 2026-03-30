@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - A Running Execution Fails Because The Domain Is Processing A Config Update

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @search_task_fails @internal
  Scenario: a running execution fails because the domain is processing a config update
    Given an execution is "RUNNING"
    And the domain is "PROCESSING"
    When a running execution fails because the domain is processing a config update
    Then the execution is "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @search_task_fails @internal
  Scenario: a running execution fails because the domain is processing a config update fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails because the domain is processing a config update
    Then the operation is rejected

  @guard @negative @search_task_fails @internal
  Scenario: a running execution fails because the domain is processing a config update fails when the domain is not "PROCESSING"
    Given an execution is "RUNNING"
    And the domain is not "PROCESSING"
    When a running execution fails because the domain is processing a config update
    Then the operation is rejected
