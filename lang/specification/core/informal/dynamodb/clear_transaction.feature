@dynamodb @generated
Feature: Dynamodb - A Committed "Dynamodb" "Transaction" Is Cleared

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @clear_transaction @internal
  Scenario: a committed "dynamodb" "transaction" is cleared
    Given the "dynamodb" "transaction" was "COMMITTED"
    When a committed "dynamodb" "transaction" is cleared
    Then the "dynamodb" "transaction" "slot" will be free
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @clear_transaction @internal
  Scenario: a committed "dynamodb" "transaction" is cleared fails when the "dynamodb" "transaction" was not "COMMITTED"
    Given the "dynamodb" "transaction" was not "COMMITTED"
    When a committed "dynamodb" "transaction" is cleared
    Then the operation is rejected
