@dynamodb @generated
Feature: DYNAMODB - A "Dynamodb" "Table" Is Created

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiQueryOnlyWhenTableActive, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a "dynamodb" "table" is created
    Given the "dynamodb" "table" did not already exist
    When a "dynamodb" "table" is created
    Then the "dynamodb" "table" will be in "CREATING" state
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending writes exist only for "ACTIVE" "dynamodb" "table"s
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @create_table
  Scenario: a "dynamodb" "table" is created fails when the "dynamodb" "table" already existed
    Given the "dynamodb" "table" already existed
    When a "dynamodb" "table" is created
    Then the operation is rejected
