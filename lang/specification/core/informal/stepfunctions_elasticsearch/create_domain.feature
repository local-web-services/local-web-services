@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - An "Elasticsearch" "Domain" Is Created And Becomes Available

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given the "elasticsearch" "domain" did not already exist
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Then the "elasticsearch" "domain" will be "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @guard @negative @create_domain
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" fails when the "elasticsearch" "domain" already existed
    Given the "elasticsearch" "domain" already existed
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Then the operation is rejected
