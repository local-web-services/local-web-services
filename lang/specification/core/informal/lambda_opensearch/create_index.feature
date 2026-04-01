@lambdaopensearch @generated
Feature: LambdaOpensearch - An "Opensearch" "Index" Is Created In The "Opensearch" "Domain"

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_index
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "ACTIVE"
    And the "opensearch" "index" did not already exist
    When an "opensearch" "index" is created in the "opensearch" "domain"
    Then the "opensearch" "index" will exist and will be ready to receive documents
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @guard @negative @create_index
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When an "opensearch" "index" is created in the "opensearch" "domain"
    Then the operation is rejected

  @guard @negative @create_index @lifecycle
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" fails when the "opensearch" "domain" was not "ACTIVE"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "ACTIVE"
    When an "opensearch" "index" is created in the "opensearch" "domain"
    Then the operation is rejected

  @guard @negative @create_index
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" fails when the "opensearch" "index" already existed
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "ACTIVE"
    And the "opensearch" "index" already existed
    When an "opensearch" "index" is created in the "opensearch" "domain"
    Then the operation is rejected
