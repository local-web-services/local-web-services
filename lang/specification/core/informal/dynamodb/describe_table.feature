@dynamodb @generated
Feature: Dynamodb - A "Dynamodb" "Table" Is Described

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @describe_table
  Scenario: a "dynamodb" "table" is described
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    When a "dynamodb" "table" is described
    Then the "dynamodb" "table" metadata will be returned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @guard @negative @describe_table
  Scenario: a "dynamodb" "table" is described fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a "dynamodb" "table" is described
    Then the operation is rejected

  @guard @negative @describe_table
  Scenario: a "dynamodb" "table" is described fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When a "dynamodb" "table" is described
    Then the operation is rejected
