@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - A Running "Step Functions" "Execution" Calls An Available Elasticsearch Domain And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @search_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "elasticsearch" "domain" was "AVAILABLE"
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticsearch" "domain" it called

  @guard @negative @search_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Then the operation is rejected

  @guard @negative @search_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds fails when the "elasticsearch" "domain" was not "AVAILABLE"
    Given a "step functions" "execution" was "RUNNING"
    And the "elasticsearch" "domain" was not "AVAILABLE"
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Then the operation is rejected
