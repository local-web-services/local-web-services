@dynamodb @generated
Feature: Dynamodb - A "Dynamodb" "Item" Is Read From The "Dynamodb" "Table"

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @get_item
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And reads were not throttled
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    Then the "dynamodb" "item" value will be returned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @get_item
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @get_item @lifecycle
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @get_item @capacity
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" fails when reads were throttled
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And reads were throttled
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    Then the operation is rejected
