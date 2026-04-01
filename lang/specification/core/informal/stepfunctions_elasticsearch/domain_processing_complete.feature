@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - The "Elasticsearch" "Domain" Configuration Update Completes

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_complete @internal
  Scenario: the "elasticsearch" "domain" configuration update completes
    Given the "elasticsearch" "domain" was "PROCESSING"
    When the "elasticsearch" "domain" configuration update completes
    Then the "elasticsearch" "domain" will be "AVAILABLE" again
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @domain_processing_complete @internal
  Scenario: the "elasticsearch" "domain" configuration update completes fails when the "elasticsearch" "domain" was not "PROCESSING"
    Given the "elasticsearch" "domain" was not "PROCESSING"
    When the "elasticsearch" "domain" configuration update completes
    Then the operation is rejected
