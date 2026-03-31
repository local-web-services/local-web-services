@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - An "Opensearch" "Domain" Is Created And Becomes Active

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE"
    Given the "opensearch" "domain" did not already exist
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    Then the "opensearch" "domain" will be "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @create_domain
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" fails when the "opensearch" "domain" already existed
    Given the "opensearch" "domain" already existed
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    Then the operation is rejected
