@dynamodb @generated
Feature: DYNAMODB - A "Dynamodb" "Table" Finishes Creating And Becomes Active

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiQueryOnlyWhenTableActive, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @activate_table @internal
  Scenario: a "dynamodb" "table" finishes creating and becomes active
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "CREATING"
    When a "dynamodb" "table" finishes creating and becomes active
    Then the "dynamodb" "table" will be "ACTIVE" and ready for reads and writes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending writes exist only for "ACTIVE" "dynamodb" "table"s
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @activate_table @internal
  Scenario: a "dynamodb" "table" finishes creating and becomes active fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a "dynamodb" "table" finishes creating and becomes active
    Then the operation is rejected

  @guard @negative @activate_table @internal
  Scenario: a "dynamodb" "table" finishes creating and becomes active fails when the "dynamodb" "table" was not "CREATING"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "CREATING"
    When a "dynamodb" "table" finishes creating and becomes active
    Then the operation is rejected
