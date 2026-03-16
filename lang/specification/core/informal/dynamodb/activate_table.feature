@dynamodb @generated
Feature: Dynamodb - A Table Finishes Creating And Becomes Active

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @activate_table @internal
  Scenario: a table finishes creating and becomes active
    Given the table exists
    And the table is "CREATING"
    When a table finishes creating and becomes active
    Then the table is "ACTIVE" and ready for reads and writes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @standard @negative @activate_table @internal
  Scenario: a table finishes creating and becomes active fails when the table does not exist
    Given the table does not exist
    When a table finishes creating and becomes active
    Then the operation is rejected

  @standard @negative @activate_table @internal
  Scenario: a table finishes creating and becomes active fails when the table is not "CREATING"
    Given the table exists
    And the table is not "CREATING"
    When a table finishes creating and becomes active
    Then the operation is rejected
