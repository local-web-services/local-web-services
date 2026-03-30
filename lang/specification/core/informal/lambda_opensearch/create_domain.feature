@lambdaopensearch @generated
Feature: LambdaOpensearch - An Opensearch Domain Is Created

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an OpenSearch domain is created
    Given the domain does not already exist
    When an OpenSearch domain is created
    Then the domain is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @guard @negative @create_domain
  Scenario: an OpenSearch domain is created fails when the domain already exists
    Given the domain already exists
    When an OpenSearch domain is created
    Then the operation is rejected
