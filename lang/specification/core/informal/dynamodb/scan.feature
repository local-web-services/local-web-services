@dynamodb @generated
Feature: Dynamodb - All Items In The Table Are Scanned

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @scan
  Scenario: all items in the table are scanned
    Given the table exists
    And the table is "ACTIVE"
    And reads are not throttled
    When all items in the table are scanned
    Then all items are returned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @standard @negative @scan
  Scenario: all items in the table are scanned fails when the table does not exist
    Given the table does not exist
    When all items in the table are scanned
    Then the operation is rejected

  @standard @negative @scan @lifecycle @internal
  Scenario: all items in the table are scanned fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When all items in the table are scanned
    Then the operation is rejected

  @standard @negative @scan @capacity @internal
  Scenario: all items in the table are scanned fails when reads are throttled
    Given the table exists
    And the table is "ACTIVE"
    And reads are throttled
    When all items in the table are scanned
    Then the operation is rejected
