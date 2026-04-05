@dynamodb @generated
Feature: DYNAMODB - A "Dynamodb" "Table" Is Described

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiQueryOnlyWhenTableActive, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @describe_table
  Scenario: a "dynamodb" "table" is described
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    When a "dynamodb" "table" is described
    Then the "dynamodb" "table" metadata will be returned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending writes exist only for "ACTIVE" "dynamodb" "table"s
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @describe_table
  Scenario: a "dynamodb" "table" is described fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a "dynamodb" "table" is described
    Then the operation is rejected

  @guard @negative @describe_table
  Scenario: a "dynamodb" "table" is described fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When a "dynamodb" "table" is described
    Then the operation is rejected
