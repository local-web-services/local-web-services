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
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @guard @negative @create_domain
  Scenario: an "opensearch" "domain" is created fails when the "opensearch" "domain" already existed
    Given the "opensearch" "domain" already existed
    When an "opensearch" "domain" is created
    Then the operation is rejected
