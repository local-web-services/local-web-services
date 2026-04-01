@dynamodb @generated
Feature: Dynamodb - An Existing "Dynamodb" "Item" Is Deleted From The "Dynamodb" "Table"

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @delete_item
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And writes were not throttled
    And the "dynamodb" "item" existed
    And the "dynamodb" "item" was present
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Then the "dynamodb" "item" will be "DELETED" or unchanged (conditional delete)
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @delete_item
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @delete_item @lifecycle
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @delete_item @capacity
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" fails when writes were throttled
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And writes were throttled
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @delete_item
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" fails when the "dynamodb" "item" did not exist
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And writes were not throttled
    And the "dynamodb" "item" did not exist
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @delete_item
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" fails when the "dynamodb" "item" was not present
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And writes were not throttled
    And the "dynamodb" "item" existed
    And the "dynamodb" "item" was not present
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Then the operation is rejected
