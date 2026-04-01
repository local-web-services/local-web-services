@dynamodb @generated
Feature: Dynamodb - A Pending "Dynamodb" "Transaction" Resolves Non-Deterministically

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @commit_transaction @internal
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically
    Given a "dynamodb" "transaction" was "PENDING"
    And the transaction's "dynamodb" "table" existed
    And the transaction's "dynamodb" "table" was "ACTIVE"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    Then the "dynamodb" "transaction" will be "COMMITTED" or "ROLLED_BACK"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @commit_transaction @internal
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically fails when no "dynamodb" "transaction" was "PENDING"
    Given no "dynamodb" "transaction" was "PENDING"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    Then the operation is rejected

  @guard @negative @commit_transaction @internal
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically fails when the transaction's "dynamodb" "table" did not exist
    Given a "dynamodb" "transaction" was "PENDING"
    And the transaction's "dynamodb" "table" did not exist
    When a pending "dynamodb" "transaction" resolves non-deterministically
    Then the operation is rejected

  @guard @negative @commit_transaction @internal
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically fails when the transaction's "dynamodb" "table" was not "ACTIVE"
    Given a "dynamodb" "transaction" was "PENDING"
    And the transaction's "dynamodb" "table" existed
    And the transaction's "dynamodb" "table" was not "ACTIVE"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    Then the operation is rejected
