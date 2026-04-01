@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - A "Opensearch" "Domain" Configuration Update Begins

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_begins
  Scenario: a "opensearch" "domain" configuration update begins
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "ACTIVE"
    When a "opensearch" "domain" configuration update begins
    Then the "opensearch" "domain" will be "PROCESSING" and "API" calls may fail
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "opensearch" "domain" it called

  @guard @negative @domain_processing_begins
  Scenario: a "opensearch" "domain" configuration update begins fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When a "opensearch" "domain" configuration update begins
    Then the operation is rejected

  @guard @negative @domain_processing_begins @lifecycle
  Scenario: a "opensearch" "domain" configuration update begins fails when the "opensearch" "domain" was not "ACTIVE"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "ACTIVE"
    When a "opensearch" "domain" configuration update begins
    Then the operation is rejected
