@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - An Opensearch Domain Is Created And Becomes Active

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an OpenSearch domain is created and becomes "ACTIVE"
    Given the domain does not already exist
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then the domain is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @create_domain
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" fails when the domain already exists
    Given the domain already exists
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then the operation is rejected
