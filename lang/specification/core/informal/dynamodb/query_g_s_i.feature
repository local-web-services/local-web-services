@dynamodb @generated
Feature: DYNAMODB - "Dynamodb" "Item"S Are Queried From A "Dynamodb" "Gsi"

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiQueryOnlyWhenTableActive, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @query_g_s_i
  Scenario: "dynamodb" "item"s are queried from a "dynamodb" "GSI"
    Given the "dynamodb" "GSI" existed
    And the "dynamodb" "table" was "ACTIVE"
    And there were no writes pending propagation to the "dynamodb" "GSI"
    When "dynamodb" "item"s are queried from a "dynamodb" "GSI"
    Then matching "dynamodb" "item"s will be returned from the "dynamodb" "GSI"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending writes exist only for "ACTIVE" "dynamodb" "table"s
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @query_g_s_i
  Scenario: "dynamodb" "item"s are queried from a "dynamodb" "GSI" fails when the "dynamodb" "GSI" did not exist
    Given the "dynamodb" "GSI" did not exist
    When "dynamodb" "item"s are queried from a "dynamodb" "GSI"
    Then the operation is rejected

  @guard @negative @query_g_s_i @lifecycle
  Scenario: "dynamodb" "item"s are queried from a "dynamodb" "GSI" fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "GSI" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When "dynamodb" "item"s are queried from a "dynamodb" "GSI"
    Then the operation is rejected

  @guard @negative @query_g_s_i
  Scenario: "dynamodb" "item"s are queried from a "dynamodb" "GSI" fails when there were writes pending propagation to the "dynamodb" "GSI"
    Given the "dynamodb" "GSI" existed
    And the "dynamodb" "table" was "ACTIVE"
    And there were writes pending propagation to the "dynamodb" "GSI"
    When "dynamodb" "item"s are queried from a "dynamodb" "GSI"
    Then the operation is rejected
