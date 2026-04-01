@dynamodb @generated
Feature: Dynamodb - A "Dynamodb" "Item" Is Written To The "Dynamodb" "Table"

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @put_item
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And writes were not throttled
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    Then the "dynamodb" "item" will exist in the "dynamodb" "table" and "GSI" propagation will be pending
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @put_item
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @put_item @lifecycle
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @put_item @capacity
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" fails when writes were throttled
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And writes were throttled
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    Then the operation is rejected
