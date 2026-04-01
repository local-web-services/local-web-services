@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - A Running "Step Functions" "Execution" Fails Because The "Opensearch" "Domain" Is Processing A Config Update

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @search_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given a "step functions" "execution" was "RUNNING"
    And the "opensearch" "domain" was "PROCESSING"
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Then the "step functions" "execution" will be "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @search_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Then the operation is rejected

  @guard @negative @search_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update fails when the "opensearch" "domain" was not "PROCESSING"
    Given a "step functions" "execution" was "RUNNING"
    And the "opensearch" "domain" was not "PROCESSING"
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Then the operation is rejected
