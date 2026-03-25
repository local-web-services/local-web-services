@dynamodb @generated
Feature: Dynamodb - Action Sequences

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a table is created then a table finishes creating and becomes active
    Given name not in table_status
    When a table is created
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a table is deleted
    Given name not in table_status
    When a table is created
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a table deletion completes
    Given name not in table_status
    When a table is created
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a table is described
    Given name not in table_status
    When a table is created
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then all tables are listed
    Given name not in table_status
    When a table is created
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an item is written to the table
    Given name not in table_status
    When a table is created
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an item is conditionally written to the table
    Given name not in table_status
    When a table is created
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an item is read from the table
    Given name not in table_status
    When a table is created
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an existing item is updated in the table
    Given name not in table_status
    When a table is created
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an existing item is deleted from the table
    Given name not in table_status
    When a table is created
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then items are queried from the table by key
    Given name not in table_status
    When a table is created
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then all items in the table are scanned
    Given name not in table_status
    When a table is created
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a transactional write is initiated across one or more items
    Given name not in table_status
    When a table is created
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a pending transaction resolves non-deterministically
    Given name not in table_status
    When a table is created
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a committed transaction is cleared
    Given name not in table_status
    When a table is created
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a rolled-back transaction is cleared
    Given name not in table_status
    When a table is created
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a "GSI" catches up with pending write propagation
    Given name not in table_status
    When a table is created
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then read throttling is toggled on or off
    Given name not in table_status
    When a table is created
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then write throttling is toggled on or off
    Given name not in table_status
    When a table is created
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a table is created
    Given name in table_status
    When a table finishes creating and becomes active
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a table is deleted
    Given name in table_status
    When a table finishes creating and becomes active
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a table deletion completes
    Given name in table_status
    When a table finishes creating and becomes active
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a table is described
    Given name in table_status
    When a table finishes creating and becomes active
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then all tables are listed
    Given name in table_status
    When a table finishes creating and becomes active
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an item is written to the table
    Given name in table_status
    When a table finishes creating and becomes active
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an item is conditionally written to the table
    Given name in table_status
    When a table finishes creating and becomes active
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an item is read from the table
    Given name in table_status
    When a table finishes creating and becomes active
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an existing item is updated in the table
    Given name in table_status
    When a table finishes creating and becomes active
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an existing item is deleted from the table
    Given name in table_status
    When a table finishes creating and becomes active
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then items are queried from the table by key
    Given name in table_status
    When a table finishes creating and becomes active
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then all items in the table are scanned
    Given name in table_status
    When a table finishes creating and becomes active
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a transactional write is initiated across one or more items
    Given name in table_status
    When a table finishes creating and becomes active
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a pending transaction resolves non-deterministically
    Given name in table_status
    When a table finishes creating and becomes active
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a committed transaction is cleared
    Given name in table_status
    When a table finishes creating and becomes active
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a rolled-back transaction is cleared
    Given name in table_status
    When a table finishes creating and becomes active
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a table finishes creating and becomes active
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then read throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then write throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a table is created
    Given name in table_status
    When a table is deleted
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a table finishes creating and becomes active
    Given name in table_status
    When a table is deleted
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a table deletion completes
    Given name in table_status
    When a table is deleted
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a table is described
    Given name in table_status
    When a table is deleted
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then all tables are listed
    Given name in table_status
    When a table is deleted
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an item is written to the table
    Given name in table_status
    When a table is deleted
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an item is conditionally written to the table
    Given name in table_status
    When a table is deleted
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an item is read from the table
    Given name in table_status
    When a table is deleted
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an existing item is updated in the table
    Given name in table_status
    When a table is deleted
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an existing item is deleted from the table
    Given name in table_status
    When a table is deleted
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then items are queried from the table by key
    Given name in table_status
    When a table is deleted
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then all items in the table are scanned
    Given name in table_status
    When a table is deleted
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a transactional write is initiated across one or more items
    Given name in table_status
    When a table is deleted
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a pending transaction resolves non-deterministically
    Given name in table_status
    When a table is deleted
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a committed transaction is cleared
    Given name in table_status
    When a table is deleted
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a rolled-back transaction is cleared
    Given name in table_status
    When a table is deleted
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a table is deleted
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then read throttling is toggled on or off
    Given name in table_status
    When a table is deleted
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then write throttling is toggled on or off
    Given name in table_status
    When a table is deleted
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a table is created
    Given name in table_status
    When a table deletion completes
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a table finishes creating and becomes active
    Given name in table_status
    When a table deletion completes
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a table is deleted
    Given name in table_status
    When a table deletion completes
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a table is described
    Given name in table_status
    When a table deletion completes
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then all tables are listed
    Given name in table_status
    When a table deletion completes
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an item is written to the table
    Given name in table_status
    When a table deletion completes
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an item is conditionally written to the table
    Given name in table_status
    When a table deletion completes
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an item is read from the table
    Given name in table_status
    When a table deletion completes
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an existing item is updated in the table
    Given name in table_status
    When a table deletion completes
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an existing item is deleted from the table
    Given name in table_status
    When a table deletion completes
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then items are queried from the table by key
    Given name in table_status
    When a table deletion completes
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then all items in the table are scanned
    Given name in table_status
    When a table deletion completes
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a transactional write is initiated across one or more items
    Given name in table_status
    When a table deletion completes
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a pending transaction resolves non-deterministically
    Given name in table_status
    When a table deletion completes
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a committed transaction is cleared
    Given name in table_status
    When a table deletion completes
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a rolled-back transaction is cleared
    Given name in table_status
    When a table deletion completes
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a table deletion completes
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then read throttling is toggled on or off
    Given name in table_status
    When a table deletion completes
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then write throttling is toggled on or off
    Given name in table_status
    When a table deletion completes
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a table is created
    Given name in table_status
    When a table is described
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a table finishes creating and becomes active
    Given name in table_status
    When a table is described
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a table is deleted
    Given name in table_status
    When a table is described
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a table deletion completes
    Given name in table_status
    When a table is described
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then all tables are listed
    Given name in table_status
    When a table is described
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an item is written to the table
    Given name in table_status
    When a table is described
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an item is conditionally written to the table
    Given name in table_status
    When a table is described
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an item is read from the table
    Given name in table_status
    When a table is described
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an existing item is updated in the table
    Given name in table_status
    When a table is described
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an existing item is deleted from the table
    Given name in table_status
    When a table is described
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then items are queried from the table by key
    Given name in table_status
    When a table is described
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then all items in the table are scanned
    Given name in table_status
    When a table is described
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a transactional write is initiated across one or more items
    Given name in table_status
    When a table is described
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a pending transaction resolves non-deterministically
    Given name in table_status
    When a table is described
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a committed transaction is cleared
    Given name in table_status
    When a table is described
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a rolled-back transaction is cleared
    Given name in table_status
    When a table is described
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a table is described
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then read throttling is toggled on or off
    Given name in table_status
    When a table is described
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then write throttling is toggled on or off
    Given name in table_status
    When a table is described
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table is created
    When all tables are listed
    Given name not in table_status
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table finishes creating and becomes active
    When all tables are listed
    Given name in table_status
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table is deleted
    When all tables are listed
    Given name in table_status
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table deletion completes
    When all tables are listed
    Given name in table_status
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table is described
    When all tables are listed
    Given name in table_status
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an item is written to the table
    When all tables are listed
    Given name in table_status
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an item is conditionally written to the table
    When all tables are listed
    Given name in table_status
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an item is read from the table
    When all tables are listed
    Given name in table_status
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an existing item is updated in the table
    When all tables are listed
    Given name in table_status
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an existing item is deleted from the table
    When all tables are listed
    Given name in table_status
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then items are queried from the table by key
    When all tables are listed
    Given name in table_status
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then all items in the table are scanned
    When all tables are listed
    Given name in table_status
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a transactional write is initiated across one or more items
    When all tables are listed
    Given name in table_status
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a pending transaction resolves non-deterministically
    When all tables are listed
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a committed transaction is cleared
    When all tables are listed
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a rolled-back transaction is cleared
    When all tables are listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a "GSI" catches up with pending write propagation
    When all tables are listed
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then read throttling is toggled on or off
    When all tables are listed
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then write throttling is toggled on or off
    When all tables are listed
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table is created
    Given name in table_status
    When an item is written to the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table finishes creating and becomes active
    Given name in table_status
    When an item is written to the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table is deleted
    Given name in table_status
    When an item is written to the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table deletion completes
    Given name in table_status
    When an item is written to the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table is described
    Given name in table_status
    When an item is written to the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then all tables are listed
    Given name in table_status
    When an item is written to the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then an item is conditionally written to the table
    Given name in table_status
    When an item is written to the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then an item is read from the table
    Given name in table_status
    When an item is written to the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then an existing item is updated in the table
    Given name in table_status
    When an item is written to the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then an existing item is deleted from the table
    Given name in table_status
    When an item is written to the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then items are queried from the table by key
    Given name in table_status
    When an item is written to the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then all items in the table are scanned
    Given name in table_status
    When an item is written to the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a transactional write is initiated across one or more items
    Given name in table_status
    When an item is written to the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a pending transaction resolves non-deterministically
    Given name in table_status
    When an item is written to the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a committed transaction is cleared
    Given name in table_status
    When an item is written to the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a rolled-back transaction is cleared
    Given name in table_status
    When an item is written to the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an item is written to the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then read throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then write throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table is created
    Given name in table_status
    When an item is conditionally written to the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table finishes creating and becomes active
    Given name in table_status
    When an item is conditionally written to the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table is deleted
    Given name in table_status
    When an item is conditionally written to the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table deletion completes
    Given name in table_status
    When an item is conditionally written to the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table is described
    Given name in table_status
    When an item is conditionally written to the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then all tables are listed
    Given name in table_status
    When an item is conditionally written to the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then an item is written to the table
    Given name in table_status
    When an item is conditionally written to the table
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then an item is read from the table
    Given name in table_status
    When an item is conditionally written to the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then an existing item is updated in the table
    Given name in table_status
    When an item is conditionally written to the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then an existing item is deleted from the table
    Given name in table_status
    When an item is conditionally written to the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then items are queried from the table by key
    Given name in table_status
    When an item is conditionally written to the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then all items in the table are scanned
    Given name in table_status
    When an item is conditionally written to the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a transactional write is initiated across one or more items
    Given name in table_status
    When an item is conditionally written to the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a pending transaction resolves non-deterministically
    Given name in table_status
    When an item is conditionally written to the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a committed transaction is cleared
    Given name in table_status
    When an item is conditionally written to the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a rolled-back transaction is cleared
    Given name in table_status
    When an item is conditionally written to the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an item is conditionally written to the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then read throttling is toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then write throttling is toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table is created
    Given name in table_status
    When an item is read from the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table finishes creating and becomes active
    Given name in table_status
    When an item is read from the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table is deleted
    Given name in table_status
    When an item is read from the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table deletion completes
    Given name in table_status
    When an item is read from the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table is described
    Given name in table_status
    When an item is read from the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then all tables are listed
    Given name in table_status
    When an item is read from the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then an item is written to the table
    Given name in table_status
    When an item is read from the table
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then an item is conditionally written to the table
    Given name in table_status
    When an item is read from the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then an existing item is updated in the table
    Given name in table_status
    When an item is read from the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then an existing item is deleted from the table
    Given name in table_status
    When an item is read from the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then items are queried from the table by key
    Given name in table_status
    When an item is read from the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then all items in the table are scanned
    Given name in table_status
    When an item is read from the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a transactional write is initiated across one or more items
    Given name in table_status
    When an item is read from the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a pending transaction resolves non-deterministically
    Given name in table_status
    When an item is read from the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a committed transaction is cleared
    Given name in table_status
    When an item is read from the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a rolled-back transaction is cleared
    Given name in table_status
    When an item is read from the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an item is read from the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then read throttling is toggled on or off
    Given name in table_status
    When an item is read from the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then write throttling is toggled on or off
    Given name in table_status
    When an item is read from the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table is created
    Given name in table_status
    When an existing item is updated in the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table finishes creating and becomes active
    Given name in table_status
    When an existing item is updated in the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table is deleted
    Given name in table_status
    When an existing item is updated in the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table deletion completes
    Given name in table_status
    When an existing item is updated in the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table is described
    Given name in table_status
    When an existing item is updated in the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then all tables are listed
    Given name in table_status
    When an existing item is updated in the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then an item is written to the table
    Given name in table_status
    When an existing item is updated in the table
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then an item is conditionally written to the table
    Given name in table_status
    When an existing item is updated in the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then an item is read from the table
    Given name in table_status
    When an existing item is updated in the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then an existing item is deleted from the table
    Given name in table_status
    When an existing item is updated in the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then items are queried from the table by key
    Given name in table_status
    When an existing item is updated in the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then all items in the table are scanned
    Given name in table_status
    When an existing item is updated in the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a transactional write is initiated across one or more items
    Given name in table_status
    When an existing item is updated in the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a pending transaction resolves non-deterministically
    Given name in table_status
    When an existing item is updated in the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a committed transaction is cleared
    Given name in table_status
    When an existing item is updated in the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a rolled-back transaction is cleared
    Given name in table_status
    When an existing item is updated in the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an existing item is updated in the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then read throttling is toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then write throttling is toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table is created
    Given name in table_status
    When an existing item is deleted from the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table finishes creating and becomes active
    Given name in table_status
    When an existing item is deleted from the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table is deleted
    Given name in table_status
    When an existing item is deleted from the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table deletion completes
    Given name in table_status
    When an existing item is deleted from the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table is described
    Given name in table_status
    When an existing item is deleted from the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then all tables are listed
    Given name in table_status
    When an existing item is deleted from the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then an item is written to the table
    Given name in table_status
    When an existing item is deleted from the table
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then an item is conditionally written to the table
    Given name in table_status
    When an existing item is deleted from the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then an item is read from the table
    Given name in table_status
    When an existing item is deleted from the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then an existing item is updated in the table
    Given name in table_status
    When an existing item is deleted from the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then items are queried from the table by key
    Given name in table_status
    When an existing item is deleted from the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then all items in the table are scanned
    Given name in table_status
    When an existing item is deleted from the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a transactional write is initiated across one or more items
    Given name in table_status
    When an existing item is deleted from the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a pending transaction resolves non-deterministically
    Given name in table_status
    When an existing item is deleted from the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a committed transaction is cleared
    Given name in table_status
    When an existing item is deleted from the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a rolled-back transaction is cleared
    Given name in table_status
    When an existing item is deleted from the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an existing item is deleted from the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then read throttling is toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then write throttling is toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table is created
    Given name in table_status
    When items are queried from the table by key
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table finishes creating and becomes active
    Given name in table_status
    When items are queried from the table by key
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table is deleted
    Given name in table_status
    When items are queried from the table by key
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table deletion completes
    Given name in table_status
    When items are queried from the table by key
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table is described
    Given name in table_status
    When items are queried from the table by key
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then all tables are listed
    Given name in table_status
    When items are queried from the table by key
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an item is written to the table
    Given name in table_status
    When items are queried from the table by key
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an item is conditionally written to the table
    Given name in table_status
    When items are queried from the table by key
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an item is read from the table
    Given name in table_status
    When items are queried from the table by key
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an existing item is updated in the table
    Given name in table_status
    When items are queried from the table by key
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an existing item is deleted from the table
    Given name in table_status
    When items are queried from the table by key
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then all items in the table are scanned
    Given name in table_status
    When items are queried from the table by key
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a transactional write is initiated across one or more items
    Given name in table_status
    When items are queried from the table by key
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a pending transaction resolves non-deterministically
    Given name in table_status
    When items are queried from the table by key
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a committed transaction is cleared
    Given name in table_status
    When items are queried from the table by key
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a rolled-back transaction is cleared
    Given name in table_status
    When items are queried from the table by key
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a "GSI" catches up with pending write propagation
    Given name in table_status
    When items are queried from the table by key
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then read throttling is toggled on or off
    Given name in table_status
    When items are queried from the table by key
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then write throttling is toggled on or off
    Given name in table_status
    When items are queried from the table by key
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table is created
    Given name in table_status
    When all items in the table are scanned
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table finishes creating and becomes active
    Given name in table_status
    When all items in the table are scanned
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table is deleted
    Given name in table_status
    When all items in the table are scanned
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table deletion completes
    Given name in table_status
    When all items in the table are scanned
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table is described
    Given name in table_status
    When all items in the table are scanned
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then all tables are listed
    Given name in table_status
    When all items in the table are scanned
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an item is written to the table
    Given name in table_status
    When all items in the table are scanned
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an item is conditionally written to the table
    Given name in table_status
    When all items in the table are scanned
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an item is read from the table
    Given name in table_status
    When all items in the table are scanned
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an existing item is updated in the table
    Given name in table_status
    When all items in the table are scanned
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an existing item is deleted from the table
    Given name in table_status
    When all items in the table are scanned
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then items are queried from the table by key
    Given name in table_status
    When all items in the table are scanned
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a transactional write is initiated across one or more items
    Given name in table_status
    When all items in the table are scanned
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a pending transaction resolves non-deterministically
    Given name in table_status
    When all items in the table are scanned
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a committed transaction is cleared
    Given name in table_status
    When all items in the table are scanned
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a rolled-back transaction is cleared
    Given name in table_status
    When all items in the table are scanned
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a "GSI" catches up with pending write propagation
    Given name in table_status
    When all items in the table are scanned
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then read throttling is toggled on or off
    Given name in table_status
    When all items in the table are scanned
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then write throttling is toggled on or off
    Given name in table_status
    When all items in the table are scanned
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table is created
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table finishes creating and becomes active
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table is deleted
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table deletion completes
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table is described
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then all tables are listed
    Given name in table_status
    When a transactional write is initiated across one or more items
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an item is written to the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an item is conditionally written to the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an item is read from the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an existing item is updated in the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an existing item is deleted from the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then items are queried from the table by key
    Given name in table_status
    When a transactional write is initiated across one or more items
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then all items in the table are scanned
    Given name in table_status
    When a transactional write is initiated across one or more items
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a pending transaction resolves non-deterministically
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a committed transaction is cleared
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a rolled-back transaction is cleared
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then read throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then write throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is created
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table finishes creating and becomes active
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is deleted
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table deletion completes
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is described
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then all tables are listed
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is written to the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is conditionally written to the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is read from the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an existing item is updated in the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an existing item is deleted from the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then items are queried from the table by key
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then all items in the table are scanned
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a transactional write is initiated across one or more items
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a committed transaction is cleared
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a rolled-back transaction is cleared
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a "GSI" catches up with pending write propagation
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then read throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then write throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table is created
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table finishes creating and becomes active
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table is deleted
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table deletion completes
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table is described
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then all tables are listed
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an item is written to the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an item is conditionally written to the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an item is read from the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an existing item is updated in the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an existing item is deleted from the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then items are queried from the table by key
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then all items in the table are scanned
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a transactional write is initiated across one or more items
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a pending transaction resolves non-deterministically
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a rolled-back transaction is cleared
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a "GSI" catches up with pending write propagation
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then read throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then write throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table is created
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table finishes creating and becomes active
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table is deleted
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table deletion completes
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table is described
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then all tables are listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an item is written to the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an item is conditionally written to the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an item is read from the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an existing item is updated in the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an existing item is deleted from the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then items are queried from the table by key
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then all items in the table are scanned
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a transactional write is initiated across one or more items
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a pending transaction resolves non-deterministically
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a committed transaction is cleared
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a "GSI" catches up with pending write propagation
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then read throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then write throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is created
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table finishes creating and becomes active
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is deleted
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table deletion completes
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is described
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then all tables are listed
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is written to the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is conditionally written to the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is read from the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an existing item is updated in the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an existing item is deleted from the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then items are queried from the table by key
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then all items in the table are scanned
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a pending transaction resolves non-deterministically
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a committed transaction is cleared
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a rolled-back transaction is cleared
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then read throttling is toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then write throttling is toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table is created
    When read throttling is toggled on or off
    Given name not in table_status
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table finishes creating and becomes active
    When read throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table is deleted
    When read throttling is toggled on or off
    Given name in table_status
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table deletion completes
    When read throttling is toggled on or off
    Given name in table_status
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table is described
    When read throttling is toggled on or off
    Given name in table_status
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then all tables are listed
    When read throttling is toggled on or off
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an item is written to the table
    When read throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an item is conditionally written to the table
    When read throttling is toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an item is read from the table
    When read throttling is toggled on or off
    Given name in table_status
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an existing item is updated in the table
    When read throttling is toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an existing item is deleted from the table
    When read throttling is toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then items are queried from the table by key
    When read throttling is toggled on or off
    Given name in table_status
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then all items in the table are scanned
    When read throttling is toggled on or off
    Given name in table_status
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a transactional write is initiated across one or more items
    When read throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a pending transaction resolves non-deterministically
    When read throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a committed transaction is cleared
    When read throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a rolled-back transaction is cleared
    When read throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a "GSI" catches up with pending write propagation
    When read throttling is toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then write throttling is toggled on or off
    When read throttling is toggled on or off
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table is created
    When write throttling is toggled on or off
    Given name not in table_status
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table finishes creating and becomes active
    When write throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table is deleted
    When write throttling is toggled on or off
    Given name in table_status
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table deletion completes
    When write throttling is toggled on or off
    Given name in table_status
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table is described
    When write throttling is toggled on or off
    Given name in table_status
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then all tables are listed
    When write throttling is toggled on or off
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an item is written to the table
    When write throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an item is conditionally written to the table
    When write throttling is toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an item is read from the table
    When write throttling is toggled on or off
    Given name in table_status
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an existing item is updated in the table
    When write throttling is toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an existing item is deleted from the table
    When write throttling is toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then items are queried from the table by key
    When write throttling is toggled on or off
    Given name in table_status
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then all items in the table are scanned
    When write throttling is toggled on or off
    Given name in table_status
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a transactional write is initiated across one or more items
    When write throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a pending transaction resolves non-deterministically
    When write throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a committed transaction is cleared
    When write throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a rolled-back transaction is cleared
    When write throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a "GSI" catches up with pending write propagation
    When write throttling is toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then read throttling is toggled on or off
    When write throttling is toggled on or off
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a table finishes creating and becomes active then a table is deleted
    Given name not in table_status
    When a table is created
    When a table finishes creating and becomes active
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a table is deleted then a table deletion completes
    Given name not in table_status
    When a table is created
    When a table is deleted
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a table deletion completes then a table is described
    Given name not in table_status
    When a table is created
    When a table deletion completes
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a table is described then all tables are listed
    Given name not in table_status
    When a table is created
    When a table is described
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then all tables are listed then an item is written to the table
    Given name not in table_status
    When a table is created
    When all tables are listed
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an item is written to the table then an item is conditionally written to the table
    Given name not in table_status
    When a table is created
    When an item is written to the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an item is conditionally written to the table then an item is read from the table
    Given name not in table_status
    When a table is created
    When an item is conditionally written to the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an item is read from the table then an existing item is updated in the table
    Given name not in table_status
    When a table is created
    When an item is read from the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an existing item is updated in the table then an existing item is deleted from the table
    Given name not in table_status
    When a table is created
    When an existing item is updated in the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then an existing item is deleted from the table then items are queried from the table by key
    Given name not in table_status
    When a table is created
    When an existing item is deleted from the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then items are queried from the table by key then all items in the table are scanned
    Given name not in table_status
    When a table is created
    When items are queried from the table by key
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then all items in the table are scanned then a transactional write is initiated across one or more items
    Given name not in table_status
    When a table is created
    When all items in the table are scanned
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a transactional write is initiated across one or more items then a pending transaction resolves non-deterministically
    Given name not in table_status
    When a table is created
    When a transactional write is initiated across one or more items
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a pending transaction resolves non-deterministically then a committed transaction is cleared
    Given name not in table_status
    When a table is created
    When a pending transaction resolves non-deterministically
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a committed transaction is cleared then a rolled-back transaction is cleared
    Given name not in table_status
    When a table is created
    When a committed transaction is cleared
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a rolled-back transaction is cleared then a "GSI" catches up with pending write propagation
    Given name not in table_status
    When a table is created
    When a rolled-back transaction is cleared
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then a "GSI" catches up with pending write propagation then read throttling is toggled on or off
    Given name not in table_status
    When a table is created
    When a "GSI" catches up with pending write propagation
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then read throttling is toggled on or off then write throttling is toggled on or off
    Given name not in table_status
    When a table is created
    When read throttling is toggled on or off
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is created then write throttling is toggled on or off then a table finishes creating and becomes active
    Given name not in table_status
    When a table is created
    When write throttling is toggled on or off
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a table is created then a table deletion completes
    Given name in table_status
    When a table finishes creating and becomes active
    When a table is created
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a table is deleted then a table is described
    Given name in table_status
    When a table finishes creating and becomes active
    When a table is deleted
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a table deletion completes then all tables are listed
    Given name in table_status
    When a table finishes creating and becomes active
    When a table deletion completes
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a table is described then an item is written to the table
    Given name in table_status
    When a table finishes creating and becomes active
    When a table is described
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then all tables are listed then an item is conditionally written to the table
    Given name in table_status
    When a table finishes creating and becomes active
    When all tables are listed
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an item is written to the table then an item is read from the table
    Given name in table_status
    When a table finishes creating and becomes active
    When an item is written to the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an item is conditionally written to the table then an existing item is updated in the table
    Given name in table_status
    When a table finishes creating and becomes active
    When an item is conditionally written to the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an item is read from the table then an existing item is deleted from the table
    Given name in table_status
    When a table finishes creating and becomes active
    When an item is read from the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an existing item is updated in the table then items are queried from the table by key
    Given name in table_status
    When a table finishes creating and becomes active
    When an existing item is updated in the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then an existing item is deleted from the table then all items in the table are scanned
    Given name in table_status
    When a table finishes creating and becomes active
    When an existing item is deleted from the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then items are queried from the table by key then a transactional write is initiated across one or more items
    Given name in table_status
    When a table finishes creating and becomes active
    When items are queried from the table by key
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then all items in the table are scanned then a pending transaction resolves non-deterministically
    Given name in table_status
    When a table finishes creating and becomes active
    When all items in the table are scanned
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a transactional write is initiated across one or more items then a committed transaction is cleared
    Given name in table_status
    When a table finishes creating and becomes active
    When a transactional write is initiated across one or more items
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a pending transaction resolves non-deterministically then a rolled-back transaction is cleared
    Given name in table_status
    When a table finishes creating and becomes active
    When a pending transaction resolves non-deterministically
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a committed transaction is cleared then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a table finishes creating and becomes active
    When a committed transaction is cleared
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a rolled-back transaction is cleared then read throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    When a rolled-back transaction is cleared
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then a "GSI" catches up with pending write propagation then write throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    When a "GSI" catches up with pending write propagation
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then read throttling is toggled on or off then a table is created
    Given name in table_status
    When a table finishes creating and becomes active
    When read throttling is toggled on or off
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table finishes creating and becomes active then write throttling is toggled on or off then a table is deleted
    Given name in table_status
    When a table finishes creating and becomes active
    When write throttling is toggled on or off
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a table is created then a table is described
    Given name in table_status
    When a table is deleted
    When a table is created
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a table finishes creating and becomes active then all tables are listed
    Given name in table_status
    When a table is deleted
    When a table finishes creating and becomes active
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a table deletion completes then an item is written to the table
    Given name in table_status
    When a table is deleted
    When a table deletion completes
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a table is described then an item is conditionally written to the table
    Given name in table_status
    When a table is deleted
    When a table is described
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then all tables are listed then an item is read from the table
    Given name in table_status
    When a table is deleted
    When all tables are listed
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an item is written to the table then an existing item is updated in the table
    Given name in table_status
    When a table is deleted
    When an item is written to the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an item is conditionally written to the table then an existing item is deleted from the table
    Given name in table_status
    When a table is deleted
    When an item is conditionally written to the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an item is read from the table then items are queried from the table by key
    Given name in table_status
    When a table is deleted
    When an item is read from the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an existing item is updated in the table then all items in the table are scanned
    Given name in table_status
    When a table is deleted
    When an existing item is updated in the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then an existing item is deleted from the table then a transactional write is initiated across one or more items
    Given name in table_status
    When a table is deleted
    When an existing item is deleted from the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then items are queried from the table by key then a pending transaction resolves non-deterministically
    Given name in table_status
    When a table is deleted
    When items are queried from the table by key
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then all items in the table are scanned then a committed transaction is cleared
    Given name in table_status
    When a table is deleted
    When all items in the table are scanned
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a transactional write is initiated across one or more items then a rolled-back transaction is cleared
    Given name in table_status
    When a table is deleted
    When a transactional write is initiated across one or more items
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a pending transaction resolves non-deterministically then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a table is deleted
    When a pending transaction resolves non-deterministically
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a committed transaction is cleared then read throttling is toggled on or off
    Given name in table_status
    When a table is deleted
    When a committed transaction is cleared
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a rolled-back transaction is cleared then write throttling is toggled on or off
    Given name in table_status
    When a table is deleted
    When a rolled-back transaction is cleared
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then a "GSI" catches up with pending write propagation then a table is created
    Given name in table_status
    When a table is deleted
    When a "GSI" catches up with pending write propagation
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then read throttling is toggled on or off then a table finishes creating and becomes active
    Given name in table_status
    When a table is deleted
    When read throttling is toggled on or off
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is deleted then write throttling is toggled on or off then a table deletion completes
    Given name in table_status
    When a table is deleted
    When write throttling is toggled on or off
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a table is created then all tables are listed
    Given name in table_status
    When a table deletion completes
    When a table is created
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a table finishes creating and becomes active then an item is written to the table
    Given name in table_status
    When a table deletion completes
    When a table finishes creating and becomes active
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a table is deleted then an item is conditionally written to the table
    Given name in table_status
    When a table deletion completes
    When a table is deleted
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a table is described then an item is read from the table
    Given name in table_status
    When a table deletion completes
    When a table is described
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then all tables are listed then an existing item is updated in the table
    Given name in table_status
    When a table deletion completes
    When all tables are listed
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an item is written to the table then an existing item is deleted from the table
    Given name in table_status
    When a table deletion completes
    When an item is written to the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an item is conditionally written to the table then items are queried from the table by key
    Given name in table_status
    When a table deletion completes
    When an item is conditionally written to the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an item is read from the table then all items in the table are scanned
    Given name in table_status
    When a table deletion completes
    When an item is read from the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an existing item is updated in the table then a transactional write is initiated across one or more items
    Given name in table_status
    When a table deletion completes
    When an existing item is updated in the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then an existing item is deleted from the table then a pending transaction resolves non-deterministically
    Given name in table_status
    When a table deletion completes
    When an existing item is deleted from the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then items are queried from the table by key then a committed transaction is cleared
    Given name in table_status
    When a table deletion completes
    When items are queried from the table by key
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then all items in the table are scanned then a rolled-back transaction is cleared
    Given name in table_status
    When a table deletion completes
    When all items in the table are scanned
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a transactional write is initiated across one or more items then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a table deletion completes
    When a transactional write is initiated across one or more items
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a pending transaction resolves non-deterministically then read throttling is toggled on or off
    Given name in table_status
    When a table deletion completes
    When a pending transaction resolves non-deterministically
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a committed transaction is cleared then write throttling is toggled on or off
    Given name in table_status
    When a table deletion completes
    When a committed transaction is cleared
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a rolled-back transaction is cleared then a table is created
    Given name in table_status
    When a table deletion completes
    When a rolled-back transaction is cleared
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then a "GSI" catches up with pending write propagation then a table finishes creating and becomes active
    Given name in table_status
    When a table deletion completes
    When a "GSI" catches up with pending write propagation
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then read throttling is toggled on or off then a table is deleted
    Given name in table_status
    When a table deletion completes
    When read throttling is toggled on or off
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table deletion completes then write throttling is toggled on or off then a table is described
    Given name in table_status
    When a table deletion completes
    When write throttling is toggled on or off
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a table is created then an item is written to the table
    Given name in table_status
    When a table is described
    When a table is created
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a table finishes creating and becomes active then an item is conditionally written to the table
    Given name in table_status
    When a table is described
    When a table finishes creating and becomes active
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a table is deleted then an item is read from the table
    Given name in table_status
    When a table is described
    When a table is deleted
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a table deletion completes then an existing item is updated in the table
    Given name in table_status
    When a table is described
    When a table deletion completes
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then all tables are listed then an existing item is deleted from the table
    Given name in table_status
    When a table is described
    When all tables are listed
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an item is written to the table then items are queried from the table by key
    Given name in table_status
    When a table is described
    When an item is written to the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an item is conditionally written to the table then all items in the table are scanned
    Given name in table_status
    When a table is described
    When an item is conditionally written to the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an item is read from the table then a transactional write is initiated across one or more items
    Given name in table_status
    When a table is described
    When an item is read from the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an existing item is updated in the table then a pending transaction resolves non-deterministically
    Given name in table_status
    When a table is described
    When an existing item is updated in the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then an existing item is deleted from the table then a committed transaction is cleared
    Given name in table_status
    When a table is described
    When an existing item is deleted from the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then items are queried from the table by key then a rolled-back transaction is cleared
    Given name in table_status
    When a table is described
    When items are queried from the table by key
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then all items in the table are scanned then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a table is described
    When all items in the table are scanned
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a transactional write is initiated across one or more items then read throttling is toggled on or off
    Given name in table_status
    When a table is described
    When a transactional write is initiated across one or more items
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a pending transaction resolves non-deterministically then write throttling is toggled on or off
    Given name in table_status
    When a table is described
    When a pending transaction resolves non-deterministically
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a committed transaction is cleared then a table is created
    Given name in table_status
    When a table is described
    When a committed transaction is cleared
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a rolled-back transaction is cleared then a table finishes creating and becomes active
    Given name in table_status
    When a table is described
    When a rolled-back transaction is cleared
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then a "GSI" catches up with pending write propagation then a table is deleted
    Given name in table_status
    When a table is described
    When a "GSI" catches up with pending write propagation
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then read throttling is toggled on or off then a table deletion completes
    Given name in table_status
    When a table is described
    When read throttling is toggled on or off
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a table is described then write throttling is toggled on or off then all tables are listed
    Given name in table_status
    When a table is described
    When write throttling is toggled on or off
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table is created then an item is conditionally written to the table
    When all tables are listed
    Given name not in table_status
    When a table is created
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table finishes creating and becomes active then an item is read from the table
    When all tables are listed
    Given name in table_status
    When a table finishes creating and becomes active
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table is deleted then an existing item is updated in the table
    When all tables are listed
    Given name in table_status
    When a table is deleted
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table deletion completes then an existing item is deleted from the table
    When all tables are listed
    Given name in table_status
    When a table deletion completes
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a table is described then items are queried from the table by key
    When all tables are listed
    Given name in table_status
    When a table is described
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an item is written to the table then all items in the table are scanned
    When all tables are listed
    Given name in table_status
    When an item is written to the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an item is conditionally written to the table then a transactional write is initiated across one or more items
    When all tables are listed
    Given name in table_status
    When an item is conditionally written to the table
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an item is read from the table then a pending transaction resolves non-deterministically
    When all tables are listed
    Given name in table_status
    When an item is read from the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an existing item is updated in the table then a committed transaction is cleared
    When all tables are listed
    Given name in table_status
    When an existing item is updated in the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then an existing item is deleted from the table then a rolled-back transaction is cleared
    When all tables are listed
    Given name in table_status
    When an existing item is deleted from the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then items are queried from the table by key then a "GSI" catches up with pending write propagation
    When all tables are listed
    Given name in table_status
    When items are queried from the table by key
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then all items in the table are scanned then read throttling is toggled on or off
    When all tables are listed
    Given name in table_status
    When all items in the table are scanned
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a transactional write is initiated across one or more items then write throttling is toggled on or off
    When all tables are listed
    Given name in table_status
    When a transactional write is initiated across one or more items
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a pending transaction resolves non-deterministically then a table is created
    When all tables are listed
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a committed transaction is cleared then a table finishes creating and becomes active
    When all tables are listed
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a rolled-back transaction is cleared then a table is deleted
    When all tables are listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then a "GSI" catches up with pending write propagation then a table deletion completes
    When all tables are listed
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then read throttling is toggled on or off then a table is described
    When all tables are listed
    When read throttling is toggled on or off
    Given name in table_status
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all tables are listed then write throttling is toggled on or off then an item is written to the table
    When all tables are listed
    When write throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table is created then an item is read from the table
    Given name in table_status
    When an item is written to the table
    When a table is created
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table finishes creating and becomes active then an existing item is updated in the table
    Given name in table_status
    When an item is written to the table
    When a table finishes creating and becomes active
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table is deleted then an existing item is deleted from the table
    Given name in table_status
    When an item is written to the table
    When a table is deleted
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table deletion completes then items are queried from the table by key
    Given name in table_status
    When an item is written to the table
    When a table deletion completes
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a table is described then all items in the table are scanned
    Given name in table_status
    When an item is written to the table
    When a table is described
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then all tables are listed then a transactional write is initiated across one or more items
    Given name in table_status
    When an item is written to the table
    When all tables are listed
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then an item is conditionally written to the table then a pending transaction resolves non-deterministically
    Given name in table_status
    When an item is written to the table
    When an item is conditionally written to the table
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then an item is read from the table then a committed transaction is cleared
    Given name in table_status
    When an item is written to the table
    When an item is read from the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then an existing item is updated in the table then a rolled-back transaction is cleared
    Given name in table_status
    When an item is written to the table
    When an existing item is updated in the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then an existing item is deleted from the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an item is written to the table
    When an existing item is deleted from the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then items are queried from the table by key then read throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    When items are queried from the table by key
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then all items in the table are scanned then write throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    When all items in the table are scanned
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a transactional write is initiated across one or more items then a table is created
    Given name in table_status
    When an item is written to the table
    When a transactional write is initiated across one or more items
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a pending transaction resolves non-deterministically then a table finishes creating and becomes active
    Given name in table_status
    When an item is written to the table
    When a pending transaction resolves non-deterministically
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a committed transaction is cleared then a table is deleted
    Given name in table_status
    When an item is written to the table
    When a committed transaction is cleared
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a rolled-back transaction is cleared then a table deletion completes
    Given name in table_status
    When an item is written to the table
    When a rolled-back transaction is cleared
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then a "GSI" catches up with pending write propagation then a table is described
    Given name in table_status
    When an item is written to the table
    When a "GSI" catches up with pending write propagation
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then read throttling is toggled on or off then all tables are listed
    Given name in table_status
    When an item is written to the table
    When read throttling is toggled on or off
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is written to the table then write throttling is toggled on or off then an item is conditionally written to the table
    Given name in table_status
    When an item is written to the table
    When write throttling is toggled on or off
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table is created then an existing item is updated in the table
    Given name in table_status
    When an item is conditionally written to the table
    When a table is created
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table finishes creating and becomes active then an existing item is deleted from the table
    Given name in table_status
    When an item is conditionally written to the table
    When a table finishes creating and becomes active
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table is deleted then items are queried from the table by key
    Given name in table_status
    When an item is conditionally written to the table
    When a table is deleted
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table deletion completes then all items in the table are scanned
    Given name in table_status
    When an item is conditionally written to the table
    When a table deletion completes
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a table is described then a transactional write is initiated across one or more items
    Given name in table_status
    When an item is conditionally written to the table
    When a table is described
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then all tables are listed then a pending transaction resolves non-deterministically
    Given name in table_status
    When an item is conditionally written to the table
    When all tables are listed
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then an item is written to the table then a committed transaction is cleared
    Given name in table_status
    When an item is conditionally written to the table
    When an item is written to the table
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then an item is read from the table then a rolled-back transaction is cleared
    Given name in table_status
    When an item is conditionally written to the table
    When an item is read from the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then an existing item is updated in the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an item is conditionally written to the table
    When an existing item is updated in the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then an existing item is deleted from the table then read throttling is toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    When an existing item is deleted from the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then items are queried from the table by key then write throttling is toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    When items are queried from the table by key
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then all items in the table are scanned then a table is created
    Given name in table_status
    When an item is conditionally written to the table
    When all items in the table are scanned
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a transactional write is initiated across one or more items then a table finishes creating and becomes active
    Given name in table_status
    When an item is conditionally written to the table
    When a transactional write is initiated across one or more items
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a pending transaction resolves non-deterministically then a table is deleted
    Given name in table_status
    When an item is conditionally written to the table
    When a pending transaction resolves non-deterministically
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a committed transaction is cleared then a table deletion completes
    Given name in table_status
    When an item is conditionally written to the table
    When a committed transaction is cleared
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a rolled-back transaction is cleared then a table is described
    Given name in table_status
    When an item is conditionally written to the table
    When a rolled-back transaction is cleared
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then a "GSI" catches up with pending write propagation then all tables are listed
    Given name in table_status
    When an item is conditionally written to the table
    When a "GSI" catches up with pending write propagation
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then read throttling is toggled on or off then an item is written to the table
    Given name in table_status
    When an item is conditionally written to the table
    When read throttling is toggled on or off
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is conditionally written to the table then write throttling is toggled on or off then an item is read from the table
    Given name in table_status
    When an item is conditionally written to the table
    When write throttling is toggled on or off
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table is created then an existing item is deleted from the table
    Given name in table_status
    When an item is read from the table
    When a table is created
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table finishes creating and becomes active then items are queried from the table by key
    Given name in table_status
    When an item is read from the table
    When a table finishes creating and becomes active
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table is deleted then all items in the table are scanned
    Given name in table_status
    When an item is read from the table
    When a table is deleted
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table deletion completes then a transactional write is initiated across one or more items
    Given name in table_status
    When an item is read from the table
    When a table deletion completes
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a table is described then a pending transaction resolves non-deterministically
    Given name in table_status
    When an item is read from the table
    When a table is described
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then all tables are listed then a committed transaction is cleared
    Given name in table_status
    When an item is read from the table
    When all tables are listed
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then an item is written to the table then a rolled-back transaction is cleared
    Given name in table_status
    When an item is read from the table
    When an item is written to the table
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then an item is conditionally written to the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an item is read from the table
    When an item is conditionally written to the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then an existing item is updated in the table then read throttling is toggled on or off
    Given name in table_status
    When an item is read from the table
    When an existing item is updated in the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then an existing item is deleted from the table then write throttling is toggled on or off
    Given name in table_status
    When an item is read from the table
    When an existing item is deleted from the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then items are queried from the table by key then a table is created
    Given name in table_status
    When an item is read from the table
    When items are queried from the table by key
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then all items in the table are scanned then a table finishes creating and becomes active
    Given name in table_status
    When an item is read from the table
    When all items in the table are scanned
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a transactional write is initiated across one or more items then a table is deleted
    Given name in table_status
    When an item is read from the table
    When a transactional write is initiated across one or more items
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a pending transaction resolves non-deterministically then a table deletion completes
    Given name in table_status
    When an item is read from the table
    When a pending transaction resolves non-deterministically
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a committed transaction is cleared then a table is described
    Given name in table_status
    When an item is read from the table
    When a committed transaction is cleared
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a rolled-back transaction is cleared then all tables are listed
    Given name in table_status
    When an item is read from the table
    When a rolled-back transaction is cleared
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then a "GSI" catches up with pending write propagation then an item is written to the table
    Given name in table_status
    When an item is read from the table
    When a "GSI" catches up with pending write propagation
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then read throttling is toggled on or off then an item is conditionally written to the table
    Given name in table_status
    When an item is read from the table
    When read throttling is toggled on or off
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an item is read from the table then write throttling is toggled on or off then an existing item is updated in the table
    Given name in table_status
    When an item is read from the table
    When write throttling is toggled on or off
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table is created then items are queried from the table by key
    Given name in table_status
    When an existing item is updated in the table
    When a table is created
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table finishes creating and becomes active then all items in the table are scanned
    Given name in table_status
    When an existing item is updated in the table
    When a table finishes creating and becomes active
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table is deleted then a transactional write is initiated across one or more items
    Given name in table_status
    When an existing item is updated in the table
    When a table is deleted
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table deletion completes then a pending transaction resolves non-deterministically
    Given name in table_status
    When an existing item is updated in the table
    When a table deletion completes
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a table is described then a committed transaction is cleared
    Given name in table_status
    When an existing item is updated in the table
    When a table is described
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then all tables are listed then a rolled-back transaction is cleared
    Given name in table_status
    When an existing item is updated in the table
    When all tables are listed
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then an item is written to the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an existing item is updated in the table
    When an item is written to the table
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then an item is conditionally written to the table then read throttling is toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    When an item is conditionally written to the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then an item is read from the table then write throttling is toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    When an item is read from the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then an existing item is deleted from the table then a table is created
    Given name in table_status
    When an existing item is updated in the table
    When an existing item is deleted from the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then items are queried from the table by key then a table finishes creating and becomes active
    Given name in table_status
    When an existing item is updated in the table
    When items are queried from the table by key
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then all items in the table are scanned then a table is deleted
    Given name in table_status
    When an existing item is updated in the table
    When all items in the table are scanned
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a transactional write is initiated across one or more items then a table deletion completes
    Given name in table_status
    When an existing item is updated in the table
    When a transactional write is initiated across one or more items
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a pending transaction resolves non-deterministically then a table is described
    Given name in table_status
    When an existing item is updated in the table
    When a pending transaction resolves non-deterministically
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a committed transaction is cleared then all tables are listed
    Given name in table_status
    When an existing item is updated in the table
    When a committed transaction is cleared
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a rolled-back transaction is cleared then an item is written to the table
    Given name in table_status
    When an existing item is updated in the table
    When a rolled-back transaction is cleared
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then a "GSI" catches up with pending write propagation then an item is conditionally written to the table
    Given name in table_status
    When an existing item is updated in the table
    When a "GSI" catches up with pending write propagation
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then read throttling is toggled on or off then an item is read from the table
    Given name in table_status
    When an existing item is updated in the table
    When read throttling is toggled on or off
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is updated in the table then write throttling is toggled on or off then an existing item is deleted from the table
    Given name in table_status
    When an existing item is updated in the table
    When write throttling is toggled on or off
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table is created then all items in the table are scanned
    Given name in table_status
    When an existing item is deleted from the table
    When a table is created
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table finishes creating and becomes active then a transactional write is initiated across one or more items
    Given name in table_status
    When an existing item is deleted from the table
    When a table finishes creating and becomes active
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table is deleted then a pending transaction resolves non-deterministically
    Given name in table_status
    When an existing item is deleted from the table
    When a table is deleted
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table deletion completes then a committed transaction is cleared
    Given name in table_status
    When an existing item is deleted from the table
    When a table deletion completes
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a table is described then a rolled-back transaction is cleared
    Given name in table_status
    When an existing item is deleted from the table
    When a table is described
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then all tables are listed then a "GSI" catches up with pending write propagation
    Given name in table_status
    When an existing item is deleted from the table
    When all tables are listed
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then an item is written to the table then read throttling is toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    When an item is written to the table
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then an item is conditionally written to the table then write throttling is toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    When an item is conditionally written to the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then an item is read from the table then a table is created
    Given name in table_status
    When an existing item is deleted from the table
    When an item is read from the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then an existing item is updated in the table then a table finishes creating and becomes active
    Given name in table_status
    When an existing item is deleted from the table
    When an existing item is updated in the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then items are queried from the table by key then a table is deleted
    Given name in table_status
    When an existing item is deleted from the table
    When items are queried from the table by key
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then all items in the table are scanned then a table deletion completes
    Given name in table_status
    When an existing item is deleted from the table
    When all items in the table are scanned
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a transactional write is initiated across one or more items then a table is described
    Given name in table_status
    When an existing item is deleted from the table
    When a transactional write is initiated across one or more items
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a pending transaction resolves non-deterministically then all tables are listed
    Given name in table_status
    When an existing item is deleted from the table
    When a pending transaction resolves non-deterministically
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a committed transaction is cleared then an item is written to the table
    Given name in table_status
    When an existing item is deleted from the table
    When a committed transaction is cleared
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a rolled-back transaction is cleared then an item is conditionally written to the table
    Given name in table_status
    When an existing item is deleted from the table
    When a rolled-back transaction is cleared
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then a "GSI" catches up with pending write propagation then an item is read from the table
    Given name in table_status
    When an existing item is deleted from the table
    When a "GSI" catches up with pending write propagation
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then read throttling is toggled on or off then an existing item is updated in the table
    Given name in table_status
    When an existing item is deleted from the table
    When read throttling is toggled on or off
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: an existing item is deleted from the table then write throttling is toggled on or off then items are queried from the table by key
    Given name in table_status
    When an existing item is deleted from the table
    When write throttling is toggled on or off
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table is created then a transactional write is initiated across one or more items
    Given name in table_status
    When items are queried from the table by key
    When a table is created
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table finishes creating and becomes active then a pending transaction resolves non-deterministically
    Given name in table_status
    When items are queried from the table by key
    When a table finishes creating and becomes active
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table is deleted then a committed transaction is cleared
    Given name in table_status
    When items are queried from the table by key
    When a table is deleted
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table deletion completes then a rolled-back transaction is cleared
    Given name in table_status
    When items are queried from the table by key
    When a table deletion completes
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a table is described then a "GSI" catches up with pending write propagation
    Given name in table_status
    When items are queried from the table by key
    When a table is described
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then all tables are listed then read throttling is toggled on or off
    Given name in table_status
    When items are queried from the table by key
    When all tables are listed
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an item is written to the table then write throttling is toggled on or off
    Given name in table_status
    When items are queried from the table by key
    When an item is written to the table
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an item is conditionally written to the table then a table is created
    Given name in table_status
    When items are queried from the table by key
    When an item is conditionally written to the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an item is read from the table then a table finishes creating and becomes active
    Given name in table_status
    When items are queried from the table by key
    When an item is read from the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an existing item is updated in the table then a table is deleted
    Given name in table_status
    When items are queried from the table by key
    When an existing item is updated in the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then an existing item is deleted from the table then a table deletion completes
    Given name in table_status
    When items are queried from the table by key
    When an existing item is deleted from the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then all items in the table are scanned then a table is described
    Given name in table_status
    When items are queried from the table by key
    When all items in the table are scanned
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a transactional write is initiated across one or more items then all tables are listed
    Given name in table_status
    When items are queried from the table by key
    When a transactional write is initiated across one or more items
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a pending transaction resolves non-deterministically then an item is written to the table
    Given name in table_status
    When items are queried from the table by key
    When a pending transaction resolves non-deterministically
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a committed transaction is cleared then an item is conditionally written to the table
    Given name in table_status
    When items are queried from the table by key
    When a committed transaction is cleared
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a rolled-back transaction is cleared then an item is read from the table
    Given name in table_status
    When items are queried from the table by key
    When a rolled-back transaction is cleared
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then a "GSI" catches up with pending write propagation then an existing item is updated in the table
    Given name in table_status
    When items are queried from the table by key
    When a "GSI" catches up with pending write propagation
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then read throttling is toggled on or off then an existing item is deleted from the table
    Given name in table_status
    When items are queried from the table by key
    When read throttling is toggled on or off
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: items are queried from the table by key then write throttling is toggled on or off then all items in the table are scanned
    Given name in table_status
    When items are queried from the table by key
    When write throttling is toggled on or off
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table is created then a pending transaction resolves non-deterministically
    Given name in table_status
    When all items in the table are scanned
    When a table is created
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table finishes creating and becomes active then a committed transaction is cleared
    Given name in table_status
    When all items in the table are scanned
    When a table finishes creating and becomes active
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table is deleted then a rolled-back transaction is cleared
    Given name in table_status
    When all items in the table are scanned
    When a table is deleted
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table deletion completes then a "GSI" catches up with pending write propagation
    Given name in table_status
    When all items in the table are scanned
    When a table deletion completes
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a table is described then read throttling is toggled on or off
    Given name in table_status
    When all items in the table are scanned
    When a table is described
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then all tables are listed then write throttling is toggled on or off
    Given name in table_status
    When all items in the table are scanned
    When all tables are listed
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an item is written to the table then a table is created
    Given name in table_status
    When all items in the table are scanned
    When an item is written to the table
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an item is conditionally written to the table then a table finishes creating and becomes active
    Given name in table_status
    When all items in the table are scanned
    When an item is conditionally written to the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an item is read from the table then a table is deleted
    Given name in table_status
    When all items in the table are scanned
    When an item is read from the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an existing item is updated in the table then a table deletion completes
    Given name in table_status
    When all items in the table are scanned
    When an existing item is updated in the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then an existing item is deleted from the table then a table is described
    Given name in table_status
    When all items in the table are scanned
    When an existing item is deleted from the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then items are queried from the table by key then all tables are listed
    Given name in table_status
    When all items in the table are scanned
    When items are queried from the table by key
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a transactional write is initiated across one or more items then an item is written to the table
    Given name in table_status
    When all items in the table are scanned
    When a transactional write is initiated across one or more items
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a pending transaction resolves non-deterministically then an item is conditionally written to the table
    Given name in table_status
    When all items in the table are scanned
    When a pending transaction resolves non-deterministically
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a committed transaction is cleared then an item is read from the table
    Given name in table_status
    When all items in the table are scanned
    When a committed transaction is cleared
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a rolled-back transaction is cleared then an existing item is updated in the table
    Given name in table_status
    When all items in the table are scanned
    When a rolled-back transaction is cleared
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then a "GSI" catches up with pending write propagation then an existing item is deleted from the table
    Given name in table_status
    When all items in the table are scanned
    When a "GSI" catches up with pending write propagation
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then read throttling is toggled on or off then items are queried from the table by key
    Given name in table_status
    When all items in the table are scanned
    When read throttling is toggled on or off
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: all items in the table are scanned then write throttling is toggled on or off then a transactional write is initiated across one or more items
    Given name in table_status
    When all items in the table are scanned
    When write throttling is toggled on or off
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table is created then a committed transaction is cleared
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table is created
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table finishes creating and becomes active then a rolled-back transaction is cleared
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table finishes creating and becomes active
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table is deleted then a "GSI" catches up with pending write propagation
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table is deleted
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table deletion completes then read throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table deletion completes
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a table is described then write throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a table is described
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then all tables are listed then a table is created
    Given name in table_status
    When a transactional write is initiated across one or more items
    When all tables are listed
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an item is written to the table then a table finishes creating and becomes active
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an item is written to the table
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an item is conditionally written to the table then a table is deleted
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an item is conditionally written to the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an item is read from the table then a table deletion completes
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an item is read from the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an existing item is updated in the table then a table is described
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an existing item is updated in the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then an existing item is deleted from the table then all tables are listed
    Given name in table_status
    When a transactional write is initiated across one or more items
    When an existing item is deleted from the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then items are queried from the table by key then an item is written to the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When items are queried from the table by key
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then all items in the table are scanned then an item is conditionally written to the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When all items in the table are scanned
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a pending transaction resolves non-deterministically then an item is read from the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a pending transaction resolves non-deterministically
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a committed transaction is cleared then an existing item is updated in the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a committed transaction is cleared
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a rolled-back transaction is cleared then an existing item is deleted from the table
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a rolled-back transaction is cleared
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then a "GSI" catches up with pending write propagation then items are queried from the table by key
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a "GSI" catches up with pending write propagation
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then read throttling is toggled on or off then all items in the table are scanned
    Given name in table_status
    When a transactional write is initiated across one or more items
    When read throttling is toggled on or off
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a transactional write is initiated across one or more items then write throttling is toggled on or off then a pending transaction resolves non-deterministically
    Given name in table_status
    When a transactional write is initiated across one or more items
    When write throttling is toggled on or off
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is created then a rolled-back transaction is cleared
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table is created
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table finishes creating and becomes active then a "GSI" catches up with pending write propagation
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table finishes creating and becomes active
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is deleted then read throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table is deleted
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table deletion completes then write throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table deletion completes
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is described then a table is created
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a table is described
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then all tables are listed then a table finishes creating and becomes active
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When all tables are listed
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is written to the table then a table is deleted
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an item is written to the table
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is conditionally written to the table then a table deletion completes
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an item is conditionally written to the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is read from the table then a table is described
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an item is read from the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an existing item is updated in the table then all tables are listed
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an existing item is updated in the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then an existing item is deleted from the table then an item is written to the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When an existing item is deleted from the table
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then items are queried from the table by key then an item is conditionally written to the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When items are queried from the table by key
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then all items in the table are scanned then an item is read from the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When all items in the table are scanned
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a transactional write is initiated across one or more items then an existing item is updated in the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a transactional write is initiated across one or more items
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a committed transaction is cleared then an existing item is deleted from the table
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a committed transaction is cleared
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a rolled-back transaction is cleared then items are queried from the table by key
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a rolled-back transaction is cleared
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then a "GSI" catches up with pending write propagation then all items in the table are scanned
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a "GSI" catches up with pending write propagation
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then read throttling is toggled on or off then a transactional write is initiated across one or more items
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When read throttling is toggled on or off
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a pending transaction resolves non-deterministically then write throttling is toggled on or off then a committed transaction is cleared
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When write throttling is toggled on or off
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table is created then a "GSI" catches up with pending write propagation
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table is created
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table finishes creating and becomes active then read throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table finishes creating and becomes active
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table is deleted then write throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table is deleted
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table deletion completes then a table is created
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table deletion completes
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a table is described then a table finishes creating and becomes active
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a table is described
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then all tables are listed then a table is deleted
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When all tables are listed
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an item is written to the table then a table deletion completes
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an item is written to the table
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an item is conditionally written to the table then a table is described
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an item is conditionally written to the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an item is read from the table then all tables are listed
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an item is read from the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an existing item is updated in the table then an item is written to the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an existing item is updated in the table
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then an existing item is deleted from the table then an item is conditionally written to the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When an existing item is deleted from the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then items are queried from the table by key then an item is read from the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When items are queried from the table by key
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then all items in the table are scanned then an existing item is updated in the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When all items in the table are scanned
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a transactional write is initiated across one or more items then an existing item is deleted from the table
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a transactional write is initiated across one or more items
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a pending transaction resolves non-deterministically then items are queried from the table by key
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a pending transaction resolves non-deterministically
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a rolled-back transaction is cleared then all items in the table are scanned
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a rolled-back transaction is cleared
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then a "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a "GSI" catches up with pending write propagation
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then read throttling is toggled on or off then a pending transaction resolves non-deterministically
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When read throttling is toggled on or off
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a committed transaction is cleared then write throttling is toggled on or off then a rolled-back transaction is cleared
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When write throttling is toggled on or off
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table is created then read throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table is created
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table finishes creating and becomes active then write throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table finishes creating and becomes active
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table is deleted then a table is created
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table is deleted
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table deletion completes then a table finishes creating and becomes active
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table deletion completes
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a table is described then a table is deleted
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a table is described
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then all tables are listed then a table deletion completes
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When all tables are listed
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an item is written to the table then a table is described
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an item is written to the table
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an item is conditionally written to the table then all tables are listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an item is conditionally written to the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an item is read from the table then an item is written to the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an item is read from the table
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an existing item is updated in the table then an item is conditionally written to the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an existing item is updated in the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then an existing item is deleted from the table then an item is read from the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When an existing item is deleted from the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then items are queried from the table by key then an existing item is updated in the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When items are queried from the table by key
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then all items in the table are scanned then an existing item is deleted from the table
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When all items in the table are scanned
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a transactional write is initiated across one or more items then items are queried from the table by key
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a transactional write is initiated across one or more items
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a pending transaction resolves non-deterministically then all items in the table are scanned
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a pending transaction resolves non-deterministically
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a committed transaction is cleared then a transactional write is initiated across one or more items
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a committed transaction is cleared
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then a "GSI" catches up with pending write propagation then a pending transaction resolves non-deterministically
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a "GSI" catches up with pending write propagation
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then read throttling is toggled on or off then a committed transaction is cleared
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When read throttling is toggled on or off
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a rolled-back transaction is cleared then write throttling is toggled on or off then a "GSI" catches up with pending write propagation
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When write throttling is toggled on or off
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is created then write throttling is toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table is created
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table finishes creating and becomes active then a table is created
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table finishes creating and becomes active
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is deleted then a table finishes creating and becomes active
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table is deleted
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table deletion completes then a table is deleted
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table deletion completes
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is described then a table deletion completes
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table is described
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then all tables are listed then a table is described
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When all tables are listed
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is written to the table then all tables are listed
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an item is written to the table
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is conditionally written to the table then an item is written to the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an item is conditionally written to the table
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is read from the table then an item is conditionally written to the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an item is read from the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an existing item is updated in the table then an item is read from the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an existing item is updated in the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then an existing item is deleted from the table then an existing item is updated in the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When an existing item is deleted from the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then items are queried from the table by key then an existing item is deleted from the table
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When items are queried from the table by key
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then all items in the table are scanned then items are queried from the table by key
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When all items in the table are scanned
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items then all items in the table are scanned
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a transactional write is initiated across one or more items
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a pending transaction resolves non-deterministically then a transactional write is initiated across one or more items
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a pending transaction resolves non-deterministically
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a committed transaction is cleared then a pending transaction resolves non-deterministically
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a committed transaction is cleared
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then a rolled-back transaction is cleared then a committed transaction is cleared
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a rolled-back transaction is cleared
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then read throttling is toggled on or off then a rolled-back transaction is cleared
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When read throttling is toggled on or off
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: a "GSI" catches up with pending write propagation then write throttling is toggled on or off then read throttling is toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When write throttling is toggled on or off
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table is created then a table finishes creating and becomes active
    When read throttling is toggled on or off
    Given name not in table_status
    When a table is created
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table finishes creating and becomes active then a table is deleted
    When read throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table is deleted then a table deletion completes
    When read throttling is toggled on or off
    Given name in table_status
    When a table is deleted
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table deletion completes then a table is described
    When read throttling is toggled on or off
    Given name in table_status
    When a table deletion completes
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a table is described then all tables are listed
    When read throttling is toggled on or off
    Given name in table_status
    When a table is described
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then all tables are listed then an item is written to the table
    When read throttling is toggled on or off
    When all tables are listed
    Given name in table_status
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an item is written to the table then an item is conditionally written to the table
    When read throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an item is conditionally written to the table then an item is read from the table
    When read throttling is toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an item is read from the table then an existing item is updated in the table
    When read throttling is toggled on or off
    Given name in table_status
    When an item is read from the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an existing item is updated in the table then an existing item is deleted from the table
    When read throttling is toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then an existing item is deleted from the table then items are queried from the table by key
    When read throttling is toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then items are queried from the table by key then all items in the table are scanned
    When read throttling is toggled on or off
    Given name in table_status
    When items are queried from the table by key
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then all items in the table are scanned then a transactional write is initiated across one or more items
    When read throttling is toggled on or off
    Given name in table_status
    When all items in the table are scanned
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a transactional write is initiated across one or more items then a pending transaction resolves non-deterministically
    When read throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a pending transaction resolves non-deterministically then a committed transaction is cleared
    When read throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a committed transaction is cleared then a rolled-back transaction is cleared
    When read throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a rolled-back transaction is cleared then a "GSI" catches up with pending write propagation
    When read throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then a "GSI" catches up with pending write propagation then write throttling is toggled on or off
    When read throttling is toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When write throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: read throttling is toggled on or off then write throttling is toggled on or off then a table is created
    When read throttling is toggled on or off
    When write throttling is toggled on or off
    Given name not in table_status
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table is created then a table is deleted
    When write throttling is toggled on or off
    Given name not in table_status
    When a table is created
    When a table is deleted
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table finishes creating and becomes active then a table deletion completes
    When write throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    When a table deletion completes
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table is deleted then a table is described
    When write throttling is toggled on or off
    Given name in table_status
    When a table is deleted
    When a table is described
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table deletion completes then all tables are listed
    When write throttling is toggled on or off
    Given name in table_status
    When a table deletion completes
    When all tables are listed
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a table is described then an item is written to the table
    When write throttling is toggled on or off
    Given name in table_status
    When a table is described
    When an item is written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then all tables are listed then an item is conditionally written to the table
    When write throttling is toggled on or off
    When all tables are listed
    Given name in table_status
    When an item is conditionally written to the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an item is written to the table then an item is read from the table
    When write throttling is toggled on or off
    Given name in table_status
    When an item is written to the table
    When an item is read from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an item is conditionally written to the table then an existing item is updated in the table
    When write throttling is toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    When an existing item is updated in the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an item is read from the table then an existing item is deleted from the table
    When write throttling is toggled on or off
    Given name in table_status
    When an item is read from the table
    When an existing item is deleted from the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an existing item is updated in the table then items are queried from the table by key
    When write throttling is toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    When items are queried from the table by key
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then an existing item is deleted from the table then all items in the table are scanned
    When write throttling is toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    When all items in the table are scanned
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then items are queried from the table by key then a transactional write is initiated across one or more items
    When write throttling is toggled on or off
    Given name in table_status
    When items are queried from the table by key
    When a transactional write is initiated across one or more items
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then all items in the table are scanned then a pending transaction resolves non-deterministically
    When write throttling is toggled on or off
    Given name in table_status
    When all items in the table are scanned
    When a pending transaction resolves non-deterministically
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a transactional write is initiated across one or more items then a committed transaction is cleared
    When write throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    When a committed transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a pending transaction resolves non-deterministically then a rolled-back transaction is cleared
    When write throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    When a rolled-back transaction is cleared
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a committed transaction is cleared then a "GSI" catches up with pending write propagation
    When write throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    When a "GSI" catches up with pending write propagation
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a rolled-back transaction is cleared then read throttling is toggled on or off
    When write throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    When read throttling is toggled on or off
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then a "GSI" catches up with pending write propagation then a table is created
    When write throttling is toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    When a table is created
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @exhaustive @sequence
  Scenario: write throttling is toggled on or off then read throttling is toggled on or off then a table finishes creating and becomes active
    When write throttling is toggled on or off
    When read throttling is toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction
