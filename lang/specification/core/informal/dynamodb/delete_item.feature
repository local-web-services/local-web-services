@dynamodb @generated
Feature: Dynamodb - An Existing Item Is Deleted From The Table

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @delete_item
  Scenario: an existing item is deleted from the table
    Given the table exists
    And the table is "ACTIVE"
    And writes are not throttled
    And the item exists
    And the item is present
    When an existing item is deleted from the table
    Then the item is deleted or unchanged (conditional delete)
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @delete_item
  Scenario: an existing item is deleted from the table fails when the table does not exist
    Given the table does not exist
    When an existing item is deleted from the table
    Then the operation is rejected

  @guard @negative @delete_item @lifecycle
  Scenario: an existing item is deleted from the table fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When an existing item is deleted from the table
    Then the operation is rejected

  @guard @negative @delete_item @capacity
  Scenario: an existing item is deleted from the table fails when writes are throttled
    Given the table exists
    And the table is "ACTIVE"
    And writes are throttled
    When an existing item is deleted from the table
    Then the operation is rejected

  @guard @negative @delete_item
  Scenario: an existing item is deleted from the table fails when the item does not exist
    Given the table exists
    And the table is "ACTIVE"
    And writes are not throttled
    And the item does not exist
    When an existing item is deleted from the table
    Then the operation is rejected

  @guard @negative @delete_item
  Scenario: an existing item is deleted from the table fails when the item is not present
    Given the table exists
    And the table is "ACTIVE"
    And writes are not throttled
    And the item exists
    And the item is not present
    When an existing item is deleted from the table
    Then the operation is rejected
