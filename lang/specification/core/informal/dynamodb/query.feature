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
    And reads were not throttled
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Then matching items will be returned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

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
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key fails when reads were throttled
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And reads were throttled
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Then the operation is rejected
