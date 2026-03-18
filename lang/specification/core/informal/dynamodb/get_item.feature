@dynamodb @generated
Feature: Dynamodb - An Item Is Read From The Table

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @get_item
  Scenario: an item is read from the table
    Given the table exists
    And the table is "ACTIVE"
    And reads are not throttled
    When an item is read from the table
    Then the item value is returned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @standard @negative @get_item
  Scenario: an item is read from the table fails when the table does not exist
    Given the table does not exist
    When an item is read from the table
    Then the operation is rejected

  @standard @negative @get_item @lifecycle @internal
  Scenario: an item is read from the table fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When an item is read from the table
    Then the operation is rejected

  @standard @negative @get_item @capacity @internal
  Scenario: an item is read from the table fails when reads are throttled
    Given the table exists
    And the table is "ACTIVE"
    And reads are throttled
    When an item is read from the table
    Then the operation is rejected
