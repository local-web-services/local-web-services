@dynamodb @generated
Feature: Dynamodb - A Transactional Write Is Initiated Across One Or More Items In A "Dynamodb" "Table"

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @transact_write_items
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "write" throttling was not active
    And no "dynamodb" "transaction" was currently in progress
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    Then the "dynamodb" "transaction" will be "PENDING"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @guard @negative @transact_write_items
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @transact_write_items @lifecycle
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @transact_write_items @capacity
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" fails when "dynamodb" "write" throttling was active
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "write" throttling was active
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @transact_write_items
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" fails when a "dynamodb" "transaction" was currently in progress
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And "dynamodb" "write" throttling was not active
    And a "dynamodb" "transaction" was currently in progress
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    Then the operation is rejected
