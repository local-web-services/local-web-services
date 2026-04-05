@dynamodb @generated
Feature: DYNAMODB - A "Dynamodb" "Item" Is Read From The "Dynamodb" "Table"

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiQueryOnlyWhenTableActive, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @get_item
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "read" throttling was not active
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    Then the "dynamodb" "item" value will be returned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending writes exist only for "ACTIVE" "dynamodb" "table"s
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

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
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" fails when "dynamodb" "read" throttling was active
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "read" throttling was active
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    Then the operation is rejected
