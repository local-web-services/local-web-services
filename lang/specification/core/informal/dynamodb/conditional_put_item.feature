@dynamodb @generated
Feature: Dynamodb - An Item Is Conditionally Written To The Table

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @conditional_put_item
  Scenario: an item is conditionally written to the table
    Given the table exists
    And the table is "ACTIVE"
    And writes are not throttled
    When an item is conditionally written to the table
    Then the item is written if the condition holds, otherwise the write is rejected
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @standard @negative @conditional_put_item
  Scenario: an item is conditionally written to the table fails when the table does not exist
    Given the table does not exist
    When an item is conditionally written to the table
    Then the operation is rejected

  @standard @negative @conditional_put_item @lifecycle @internal
  Scenario: an item is conditionally written to the table fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When an item is conditionally written to the table
    Then the operation is rejected

  @standard @negative @conditional_put_item @capacity @internal
  Scenario: an item is conditionally written to the table fails when writes are throttled
    Given the table exists
    And the table is "ACTIVE"
    And writes are throttled
    When an item is conditionally written to the table
    Then the operation is rejected
