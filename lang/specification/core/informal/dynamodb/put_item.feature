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
    And "dynamodb" "write" throttling was not active
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    Then the "dynamodb" "item" will exist in the "dynamodb" "table" and "GSI" propagation will be pending
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

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
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" fails when "dynamodb" "write" throttling was active
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "write" throttling was active
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    Then the operation is rejected
