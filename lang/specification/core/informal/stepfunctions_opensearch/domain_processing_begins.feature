@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - A Domain Configuration Update Begins

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_begins
  Scenario: a domain configuration update begins
    Given the domain exists
    And the domain is "ACTIVE"
    When a domain configuration update begins
    Then the domain is "PROCESSING" and "API" calls may fail
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @standard @negative @domain_processing_begins
  Scenario: a domain configuration update begins fails when the domain does not exist
    Given the domain does not exist
    When a domain configuration update begins
    Then the operation is rejected

  @standard @negative @domain_processing_begins @lifecycle @internal
  Scenario: a domain configuration update begins fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When a domain configuration update begins
    Then the operation is rejected
