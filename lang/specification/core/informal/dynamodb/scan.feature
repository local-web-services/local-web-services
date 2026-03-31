@dynamodb @generated
Feature: Dynamodb - All "Dynamodb" "Item"S In The "Dynamodb" "Table" Are Scanned

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @scan
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And reads were not throttled
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Then all items will be returned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @scan
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Then the operation is rejected

  @guard @negative @scan @lifecycle
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Then the operation is rejected

  @guard @negative @scan @capacity
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned fails when reads were throttled
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And reads were throttled
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Then the operation is rejected
