@dynamodb @generated
Feature: Dynamodb - A Table Is Created

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a table is created
    Given the table does not already exist
    When a table is created
    Then the table is in "CREATING" state
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @create_table
  Scenario: a table is created fails when the table already exists
    Given the table already exists
    When a table is created
    Then the operation is rejected
