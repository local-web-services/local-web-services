@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - The "Opensearch" "Domain" Configuration Update Completes

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_complete @internal
  Scenario: the "opensearch" "domain" configuration update completes
    Given the "opensearch" "domain" was "PROCESSING"
    When the "opensearch" "domain" configuration update completes
    Then the "opensearch" "domain" will be "ACTIVE" again
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @domain_processing_complete @internal
  Scenario: the "opensearch" "domain" configuration update completes fails when the "opensearch" "domain" was not "PROCESSING"
    Given the "opensearch" "domain" was not "PROCESSING"
    When the "opensearch" "domain" configuration update completes
    Then the operation is rejected
