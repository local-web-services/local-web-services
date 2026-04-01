@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - An "Elasticsearch" "Domain" Is Created And Becomes Available

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given the "elasticsearch" "domain" did not already exist
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Then the "elasticsearch" "domain" will be "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @guard @negative @create_domain
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" fails when the "elasticsearch" "domain" already existed
    Given the "elasticsearch" "domain" already existed
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Then the operation is rejected
