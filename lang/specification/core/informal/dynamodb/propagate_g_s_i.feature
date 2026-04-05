@dynamodb @generated
Feature: DYNAMODB - A "Dynamodb" "Gsi" Catches Up With Pending Write Propagation

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiQueryOnlyWhenTableActive, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @propagate_g_s_i @internal
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation
    Given the "dynamodb" "table" had pending "GSI" propagation
    And there were writes pending propagation to the "dynamodb" "GSI"
    When a "dynamodb" "GSI" catches up with pending write propagation
    Then the "dynamodb" "GSI" will be consistent with the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending writes exist only for "ACTIVE" "dynamodb" "table"s
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @propagate_g_s_i @internal
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation fails when the "dynamodb" "table" did not have pending "GSI" propagation
    Given the "dynamodb" "table" did not have pending "GSI" propagation
    When a "dynamodb" "GSI" catches up with pending write propagation
    Then the operation is rejected

  @guard @negative @propagate_g_s_i @internal
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation fails when there were no writes pending propagation to the "dynamodb" "GSI"
    Given the "dynamodb" "table" had pending "GSI" propagation
    And there were no writes pending propagation to the "dynamodb" "GSI"
    When a "dynamodb" "GSI" catches up with pending write propagation
    Then the operation is rejected
