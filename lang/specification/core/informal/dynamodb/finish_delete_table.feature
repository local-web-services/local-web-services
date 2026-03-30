@dynamodb @generated
Feature: Dynamodb - A Table Deletion Completes

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_table @internal
  Scenario: a table deletion completes
    Given the table exists
    And the table is "DELETING"
    When a table deletion completes
    Then the table is "DELETED"
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @finish_delete_table @internal
  Scenario: a table deletion completes fails when the table does not exist
    Given the table does not exist
    When a table deletion completes
    Then the operation is rejected

  @guard @negative @finish_delete_table @internal
  Scenario: a table deletion completes fails when the table is not "DELETING"
    Given the table exists
    And the table is not "DELETING"
    When a table deletion completes
    Then the operation is rejected
