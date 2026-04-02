@dynamodb @generated
Feature: Dynamodb - "Dynamodb" "Item"S Are Queried From The "Dynamodb" "Table" By Key

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @query
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "read" throttling was not active
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Then matching "dynamodb" "item"s will be returned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @query
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Then the operation is rejected

  @guard @negative @query @lifecycle
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Then the operation is rejected

  @guard @negative @query @capacity
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key fails when "dynamodb" "read" throttling was active
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "read" throttling was active
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Then the operation is rejected
