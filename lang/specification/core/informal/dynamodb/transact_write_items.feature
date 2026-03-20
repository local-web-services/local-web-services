@dynamodb @generated
Feature: Dynamodb - A Transactional Write Is Initiated Across One Or More Items

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @transact_write_items
  Scenario: a transactional write is initiated across one or more items
    Given the table exists
    And the table is "ACTIVE"
    And writes are not throttled
    And no transaction is currently in progress
    When a transactional write is initiated across one or more items
    Then the transaction is "PENDING"
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @standard @negative @transact_write_items
  Scenario: a transactional write is initiated across one or more items fails when the table does not exist
    Given the table does not exist
    When a transactional write is initiated across one or more items
    Then the operation is rejected

  @standard @negative @transact_write_items @lifecycle
  Scenario: a transactional write is initiated across one or more items fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a transactional write is initiated across one or more items
    Then the operation is rejected

  @standard @negative @transact_write_items @capacity
  Scenario: a transactional write is initiated across one or more items fails when writes are throttled
    Given the table exists
    And the table is "ACTIVE"
    And writes are throttled
    When a transactional write is initiated across one or more items
    Then the operation is rejected

  @standard @negative @transact_write_items
  Scenario: a transactional write is initiated across one or more items fails when a transaction is currently in progress
    Given the table exists
    And the table is "ACTIVE"
    And writes are not throttled
    And a transaction is currently in progress
    When a transactional write is initiated across one or more items
    Then the operation is rejected
