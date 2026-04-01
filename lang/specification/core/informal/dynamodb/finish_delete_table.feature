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
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

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
