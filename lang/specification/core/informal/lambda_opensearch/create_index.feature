@lambdaopensearch @generated
Feature: LambdaOpensearch - An Index Is Created In The Opensearch Domain

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_index
  Scenario: an index is created in the OpenSearch domain
    Given the domain exists
    And the domain is "ACTIVE"
    And the index does not already exist
    When an index is created in the OpenSearch domain
    Then the index "EXISTS" and is ready to receive documents
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @standard @negative @create_index
  Scenario: an index is created in the OpenSearch domain fails when the domain does not exist
    Given the domain does not exist
    When an index is created in the OpenSearch domain
    Then the operation is rejected

  @standard @negative @create_index @lifecycle @internal
  Scenario: an index is created in the OpenSearch domain fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When an index is created in the OpenSearch domain
    Then the operation is rejected

  @standard @negative @create_index
  Scenario: an index is created in the OpenSearch domain fails when the index already exists
    Given the domain exists
    And the domain is "ACTIVE"
    And the index already exists
    When an index is created in the OpenSearch domain
    Then the operation is rejected
