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
    And "dynamodb" "read" throttling was not active
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Then all "dynamodb" "item"s will be returned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

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
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned fails when "dynamodb" "read" throttling was active
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "read" throttling was active
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Then the operation is rejected
