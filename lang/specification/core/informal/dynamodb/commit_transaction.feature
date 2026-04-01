@dynamodb @generated
Feature: Dynamodb - A Pending Transaction Resolves Non-Deterministically

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @commit_transaction @internal
  Scenario: a pending transaction resolves non-deterministically
    Given a transaction was "PENDING"
    And the transaction's "dynamodb" "table" existed
    And the transaction's "dynamodb" "table" was "ACTIVE"
    When a pending transaction resolves non-deterministically
    Then the transaction will be "COMMITTED" or "ROLLED_BACK"
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @commit_transaction @internal
  Scenario: a pending transaction resolves non-deterministically fails when no transaction was "PENDING"
    Given no transaction was "PENDING"
    When a pending transaction resolves non-deterministically
    Then the operation is rejected

  @guard @negative @commit_transaction @internal
  Scenario: a pending transaction resolves non-deterministically fails when the transaction's "dynamodb" "table" did not exist
    Given a transaction was "PENDING"
    And the transaction's "dynamodb" "table" did not exist
    When a pending transaction resolves non-deterministically
    Then the operation is rejected

  @guard @negative @commit_transaction @internal
  Scenario: a pending transaction resolves non-deterministically fails when the transaction's "dynamodb" "table" was not "ACTIVE"
    Given a transaction was "PENDING"
    And the transaction's "dynamodb" "table" existed
    And the transaction's "dynamodb" "table" was not "ACTIVE"
    When a pending transaction resolves non-deterministically
    Then the operation is rejected
