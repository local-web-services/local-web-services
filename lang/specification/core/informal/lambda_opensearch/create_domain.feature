@lambdaopensearch @generated
Feature: LambdaOpensearch - An "Opensearch" "Domain" Is Created

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an "opensearch" "domain" is created
    Given the "opensearch" "domain" did not already exist
    When an "opensearch" "domain" is created
    Then the "opensearch" "domain" will be "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @guard @negative @create_domain
  Scenario: an "opensearch" "domain" is created fails when the "opensearch" "domain" already existed
    Given the "opensearch" "domain" already existed
    When an "opensearch" "domain" is created
    Then the operation is rejected
