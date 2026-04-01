@dynamodb @generated
Feature: Dynamodb - An Existing "Dynamodb" "Item" Is Updated In The "Dynamodb" "Table"

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @update_item
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "write" throttling was not active
    And the "dynamodb" "item" existed
    And the "dynamodb" "item" was present
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Then the "dynamodb" "item" will be updated or unchanged (conditional update)
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @update_item
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @update_item @lifecycle
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @update_item @capacity
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" fails when "dynamodb" "write" throttling was active
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "write" throttling was active
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @update_item
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" fails when the "dynamodb" "item" did not exist
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "write" throttling was not active
    And the "dynamodb" "item" did not exist
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @update_item
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" fails when the "dynamodb" "item" was not present
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "write" throttling was not active
    And the "dynamodb" "item" existed
    And the "dynamodb" "item" was not present
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Then the operation is rejected
