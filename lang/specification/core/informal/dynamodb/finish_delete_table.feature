@dynamodb @generated
Feature: Dynamodb - A "Dynamodb" "Table" Deletion Completes

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_table @internal
  Scenario: a "dynamodb" "table" deletion completes
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "DELETING"
    When a "dynamodb" "table" deletion completes
    Then the "dynamodb" "table" will be "DELETED"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @finish_delete_table @internal
  Scenario: a "dynamodb" "table" deletion completes fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a "dynamodb" "table" deletion completes
    Then the operation is rejected

  @guard @negative @finish_delete_table @internal
  Scenario: a "dynamodb" "table" deletion completes fails when the "dynamodb" "table" was not "DELETING"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "DELETING"
    When a "dynamodb" "table" deletion completes
    Then the operation is rejected
