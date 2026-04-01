@lambdaopensearch @generated
Feature: LambdaOpensearch - The "Lambda" "Function" Invocation Completes Successfully

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation completes successfully
    Then the "lambda" "invocation" will be "SUCCESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation completes successfully
    Then the operation is rejected
