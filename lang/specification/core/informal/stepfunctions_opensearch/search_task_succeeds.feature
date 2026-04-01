@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - A Running "Step Functions" "Execution" Calls An Active Opensearch Domain And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @search_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "opensearch" "domain" was "ACTIVE"
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "opensearch" "domain" it called

  @guard @negative @search_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then the operation is rejected

  @guard @negative @search_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds fails when the "opensearch" "domain" was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the "opensearch" "domain" was not "ACTIVE"
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then the operation is rejected
