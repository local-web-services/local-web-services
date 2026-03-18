@dynamodb @generated
Feature: Dynamodb - A Table Is Described

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @describe_table
  Scenario: a table is described
    Given the table exists
    And the table is "ACTIVE"
    When a table is described
    Then the table metadata is returned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @standard @negative @describe_table
  Scenario: a table is described fails when the table does not exist
    Given the table does not exist
    When a table is described
    Then the operation is rejected

  @standard @negative @describe_table
  Scenario: a table is described fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a table is described
    Then the operation is rejected
