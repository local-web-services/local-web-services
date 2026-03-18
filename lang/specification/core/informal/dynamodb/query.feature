@dynamodb @generated
Feature: Dynamodb - Items Are Queried From The Table By Key

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @query
  Scenario: items are queried from the table by key
    Given the table exists
    And the table is "ACTIVE"
    And reads are not throttled
    When items are queried from the table by key
    Then matching items are returned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @standard @negative @query
  Scenario: items are queried from the table by key fails when the table does not exist
    Given the table does not exist
    When items are queried from the table by key
    Then the operation is rejected

  @standard @negative @query @lifecycle @internal
  Scenario: items are queried from the table by key fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When items are queried from the table by key
    Then the operation is rejected

  @standard @negative @query @capacity @internal
  Scenario: items are queried from the table by key fails when reads are throttled
    Given the table exists
    And the table is "ACTIVE"
    And reads are throttled
    When items are queried from the table by key
    Then the operation is rejected
