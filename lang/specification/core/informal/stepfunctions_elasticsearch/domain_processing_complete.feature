@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - The Domain Configuration Update Completes

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_complete @internal
  Scenario: the domain configuration update completes
    Given the domain is "PROCESSING"
    When the domain configuration update completes
    Then the domain is "AVAILABLE" again
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @standard @negative @domain_processing_complete @internal
  Scenario: the domain configuration update completes fails when the domain is not "PROCESSING"
    Given the domain is not "PROCESSING"
    When the domain configuration update completes
    Then the operation is rejected
