@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - An Elasticsearch Domain Is Created And Becomes Available

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE"
    Given the domain does not already exist
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then the domain is "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @create_domain
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" fails when the domain already exists
    Given the domain already exists
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then the operation is rejected
