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
    And writes were not throttled
    And no transaction was currently in progress
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    Then the transaction will be "PENDING"
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

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
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" fails when writes were throttled
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And writes were throttled
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @transact_write_items
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" fails when a transaction was currently in progress
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And writes were not throttled
    And a transaction was currently in progress
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    Then the operation is rejected
