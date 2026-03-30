@dynamodb @generated
Feature: Dynamodb - A Rolled-Back Transaction Is Cleared

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @clear_rolled_back @internal
  Scenario: a rolled-back transaction is cleared
    Given the transaction is "ROLLED_BACK"
    When a rolled-back transaction is cleared
    Then the transaction slot is free
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @clear_rolled_back @internal
  Scenario: a rolled-back transaction is cleared fails when the transaction is not "ROLLED_BACK"
    Given the transaction is not "ROLLED_BACK"
    When a rolled-back transaction is cleared
    Then the operation is rejected
