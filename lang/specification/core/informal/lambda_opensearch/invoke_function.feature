@lambdaopensearch @generated
Feature: LambdaOpensearch - The "Lambda" "Function" Is Invoked

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @invoke_function
  Scenario: the "lambda" "function" is invoked
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And a "lambda" "invocation" slot is available
    When the "lambda" "function" is invoked
    Then the "lambda" "invocation" will be "IN_PROGRESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @guard @negative @invoke_function
  Scenario: the "lambda" "function" is invoked fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When the "lambda" "function" is invoked
    Then the operation is rejected

  @guard @negative @invoke_function @lifecycle
  Scenario: the "lambda" "function" is invoked fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When the "lambda" "function" is invoked
    Then the operation is rejected

  @guard @negative @invoke_function @capacity
  Scenario: the "lambda" "function" is invoked fails when no "lambda" "invocation" "slot" was "available"
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And no "lambda" "invocation" "slot" was "available"
    When the "lambda" "function" is invoked
    Then the operation is rejected
