@dynamodb @generated
Feature: Dynamodb - Action Sequences

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a table is created then a table finishes creating and becomes active
    Given name not in table_status
    Given a table has been created
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a table is deleted
    Given name not in table_status
    Given a table has been created
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a table deletion completes
    Given name not in table_status
    Given a table has been created
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a table is described
    Given name not in table_status
    Given a table has been created
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then all tables are listed
    Given name not in table_status
    Given a table has been created
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an item is written to the table
    Given name not in table_status
    Given a table has been created
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an item is conditionally written to the table
    Given name not in table_status
    Given a table has been created
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an item is read from the table
    Given name not in table_status
    Given a table has been created
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an existing item is updated in the table
    Given name not in table_status
    Given a table has been created
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an existing item is deleted from the table
    Given name not in table_status
    Given a table has been created
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then items are queried from the table by key
    Given name not in table_status
    Given a table has been created
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then all items in the table are scanned
    Given name not in table_status
    Given a table has been created
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a transactional write is initiated across one or more items
    Given name not in table_status
    Given a table has been created
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a pending transaction resolves non-deterministically
    Given name not in table_status
    Given a table has been created
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a committed transaction is cleared
    Given name not in table_status
    Given a table has been created
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a rolled-back transaction is cleared
    Given name not in table_status
    Given a table has been created
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a "GSI" catches up with pending write propagation
    Given name not in table_status
    Given a table has been created
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then read throttling is toggled on or off
    Given name not in table_status
    Given a table has been created
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then write throttling is toggled on or off
    Given name not in table_status
    Given a table has been created
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a table is created
    Given name in table_status
    Given a table has finished creating and become active
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a table is deleted
    Given name in table_status
    Given a table has finished creating and become active
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a table deletion completes
    Given name in table_status
    Given a table has finished creating and become active
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a table is described
    Given name in table_status
    Given a table has finished creating and become active
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then all tables are listed
    Given name in table_status
    Given a table has finished creating and become active
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an item is written to the table
    Given name in table_status
    Given a table has finished creating and become active
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an item is conditionally written to the table
    Given name in table_status
    Given a table has finished creating and become active
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an item is read from the table
    Given name in table_status
    Given a table has finished creating and become active
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an existing item is updated in the table
    Given name in table_status
    Given a table has finished creating and become active
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an existing item is deleted from the table
    Given name in table_status
    Given a table has finished creating and become active
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then items are queried from the table by key
    Given name in table_status
    Given a table has finished creating and become active
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then all items in the table are scanned
    Given name in table_status
    Given a table has finished creating and become active
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a transactional write is initiated across one or more items
    Given name in table_status
    Given a table has finished creating and become active
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a table has finished creating and become active
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a committed transaction is cleared
    Given name in table_status
    Given a table has finished creating and become active
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a rolled-back transaction is cleared
    Given name in table_status
    Given a table has finished creating and become active
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a table has finished creating and become active
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then read throttling is toggled on or off
    Given name in table_status
    Given a table has finished creating and become active
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then write throttling is toggled on or off
    Given name in table_status
    Given a table has finished creating and become active
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a table is created
    Given name in table_status
    Given a table has been deleted
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a table finishes creating and becomes active
    Given name in table_status
    Given a table has been deleted
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a table deletion completes
    Given name in table_status
    Given a table has been deleted
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a table is described
    Given name in table_status
    Given a table has been deleted
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then all tables are listed
    Given name in table_status
    Given a table has been deleted
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an item is written to the table
    Given name in table_status
    Given a table has been deleted
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an item is conditionally written to the table
    Given name in table_status
    Given a table has been deleted
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an item is read from the table
    Given name in table_status
    Given a table has been deleted
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an existing item is updated in the table
    Given name in table_status
    Given a table has been deleted
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an existing item is deleted from the table
    Given name in table_status
    Given a table has been deleted
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then items are queried from the table by key
    Given name in table_status
    Given a table has been deleted
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then all items in the table are scanned
    Given name in table_status
    Given a table has been deleted
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a transactional write is initiated across one or more items
    Given name in table_status
    Given a table has been deleted
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a table has been deleted
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a committed transaction is cleared
    Given name in table_status
    Given a table has been deleted
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a rolled-back transaction is cleared
    Given name in table_status
    Given a table has been deleted
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a table has been deleted
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then read throttling is toggled on or off
    Given name in table_status
    Given a table has been deleted
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then write throttling is toggled on or off
    Given name in table_status
    Given a table has been deleted
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a table is created
    Given name in table_status
    Given a table deletion has completed
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a table finishes creating and becomes active
    Given name in table_status
    Given a table deletion has completed
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a table is deleted
    Given name in table_status
    Given a table deletion has completed
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a table is described
    Given name in table_status
    Given a table deletion has completed
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then all tables are listed
    Given name in table_status
    Given a table deletion has completed
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an item is written to the table
    Given name in table_status
    Given a table deletion has completed
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an item is conditionally written to the table
    Given name in table_status
    Given a table deletion has completed
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an item is read from the table
    Given name in table_status
    Given a table deletion has completed
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an existing item is updated in the table
    Given name in table_status
    Given a table deletion has completed
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an existing item is deleted from the table
    Given name in table_status
    Given a table deletion has completed
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then items are queried from the table by key
    Given name in table_status
    Given a table deletion has completed
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then all items in the table are scanned
    Given name in table_status
    Given a table deletion has completed
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a transactional write is initiated across one or more items
    Given name in table_status
    Given a table deletion has completed
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a table deletion has completed
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a committed transaction is cleared
    Given name in table_status
    Given a table deletion has completed
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a rolled-back transaction is cleared
    Given name in table_status
    Given a table deletion has completed
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a table deletion has completed
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then read throttling is toggled on or off
    Given name in table_status
    Given a table deletion has completed
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then write throttling is toggled on or off
    Given name in table_status
    Given a table deletion has completed
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a table is created
    Given name in table_status
    Given a table has been described
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a table finishes creating and becomes active
    Given name in table_status
    Given a table has been described
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a table is deleted
    Given name in table_status
    Given a table has been described
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a table deletion completes
    Given name in table_status
    Given a table has been described
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then all tables are listed
    Given name in table_status
    Given a table has been described
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an item is written to the table
    Given name in table_status
    Given a table has been described
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an item is conditionally written to the table
    Given name in table_status
    Given a table has been described
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an item is read from the table
    Given name in table_status
    Given a table has been described
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an existing item is updated in the table
    Given name in table_status
    Given a table has been described
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an existing item is deleted from the table
    Given name in table_status
    Given a table has been described
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then items are queried from the table by key
    Given name in table_status
    Given a table has been described
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then all items in the table are scanned
    Given name in table_status
    Given a table has been described
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a transactional write is initiated across one or more items
    Given name in table_status
    Given a table has been described
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a table has been described
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a committed transaction is cleared
    Given name in table_status
    Given a table has been described
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a rolled-back transaction is cleared
    Given name in table_status
    Given a table has been described
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a table has been described
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then read throttling is toggled on or off
    Given name in table_status
    Given a table has been described
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then write throttling is toggled on or off
    Given name in table_status
    Given a table has been described
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table is created
    Given all tables have been listed
    Given name not in table_status
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table finishes creating and becomes active
    Given all tables have been listed
    Given name in table_status
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table is deleted
    Given all tables have been listed
    Given name in table_status
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table deletion completes
    Given all tables have been listed
    Given name in table_status
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table is described
    Given all tables have been listed
    Given name in table_status
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an item is written to the table
    Given all tables have been listed
    Given name in table_status
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an item is conditionally written to the table
    Given all tables have been listed
    Given name in table_status
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an item is read from the table
    Given all tables have been listed
    Given name in table_status
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an existing item is updated in the table
    Given all tables have been listed
    Given name in table_status
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an existing item is deleted from the table
    Given all tables have been listed
    Given name in table_status
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then items are queried from the table by key
    Given all tables have been listed
    Given name in table_status
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then all items in the table are scanned
    Given all tables have been listed
    Given name in table_status
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a transactional write is initiated across one or more items
    Given all tables have been listed
    Given name in table_status
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a pending transaction resolves non-deterministically
    Given all tables have been listed
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a committed transaction is cleared
    Given all tables have been listed
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a rolled-back transaction is cleared
    Given all tables have been listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a "GSI" catches up with pending write propagation
    Given all tables have been listed
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then read throttling is toggled on or off
    Given all tables have been listed
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then write throttling is toggled on or off
    Given all tables have been listed
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table is created
    Given name in table_status
    Given an item has been written to the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table finishes creating and becomes active
    Given name in table_status
    Given an item has been written to the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table is deleted
    Given name in table_status
    Given an item has been written to the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table deletion completes
    Given name in table_status
    Given an item has been written to the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table is described
    Given name in table_status
    Given an item has been written to the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then all tables are listed
    Given name in table_status
    Given an item has been written to the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then an item is conditionally written to the table
    Given name in table_status
    Given an item has been written to the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then an item is read from the table
    Given name in table_status
    Given an item has been written to the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then an existing item is updated in the table
    Given name in table_status
    Given an item has been written to the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then an existing item is deleted from the table
    Given name in table_status
    Given an item has been written to the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then items are queried from the table by key
    Given name in table_status
    Given an item has been written to the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then all items in the table are scanned
    Given name in table_status
    Given an item has been written to the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a transactional write is initiated across one or more items
    Given name in table_status
    Given an item has been written to the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an item has been written to the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a committed transaction is cleared
    Given name in table_status
    Given an item has been written to the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a rolled-back transaction is cleared
    Given name in table_status
    Given an item has been written to the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an item has been written to the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then read throttling is toggled on or off
    Given name in table_status
    Given an item has been written to the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then write throttling is toggled on or off
    Given name in table_status
    Given an item has been written to the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table is created
    Given name in table_status
    Given an item has been conditionally written to the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table finishes creating and becomes active
    Given name in table_status
    Given an item has been conditionally written to the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table is deleted
    Given name in table_status
    Given an item has been conditionally written to the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table deletion completes
    Given name in table_status
    Given an item has been conditionally written to the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table is described
    Given name in table_status
    Given an item has been conditionally written to the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then all tables are listed
    Given name in table_status
    Given an item has been conditionally written to the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then an item is written to the table
    Given name in table_status
    Given an item has been conditionally written to the table
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then an item is read from the table
    Given name in table_status
    Given an item has been conditionally written to the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then an existing item is updated in the table
    Given name in table_status
    Given an item has been conditionally written to the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then an existing item is deleted from the table
    Given name in table_status
    Given an item has been conditionally written to the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then items are queried from the table by key
    Given name in table_status
    Given an item has been conditionally written to the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then all items in the table are scanned
    Given name in table_status
    Given an item has been conditionally written to the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a transactional write is initiated across one or more items
    Given name in table_status
    Given an item has been conditionally written to the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an item has been conditionally written to the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a committed transaction is cleared
    Given name in table_status
    Given an item has been conditionally written to the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a rolled-back transaction is cleared
    Given name in table_status
    Given an item has been conditionally written to the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an item has been conditionally written to the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then read throttling is toggled on or off
    Given name in table_status
    Given an item has been conditionally written to the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then write throttling is toggled on or off
    Given name in table_status
    Given an item has been conditionally written to the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table is created
    Given name in table_status
    Given an item has been read from the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table finishes creating and becomes active
    Given name in table_status
    Given an item has been read from the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table is deleted
    Given name in table_status
    Given an item has been read from the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table deletion completes
    Given name in table_status
    Given an item has been read from the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table is described
    Given name in table_status
    Given an item has been read from the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then all tables are listed
    Given name in table_status
    Given an item has been read from the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then an item is written to the table
    Given name in table_status
    Given an item has been read from the table
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then an item is conditionally written to the table
    Given name in table_status
    Given an item has been read from the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then an existing item is updated in the table
    Given name in table_status
    Given an item has been read from the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then an existing item is deleted from the table
    Given name in table_status
    Given an item has been read from the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then items are queried from the table by key
    Given name in table_status
    Given an item has been read from the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then all items in the table are scanned
    Given name in table_status
    Given an item has been read from the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a transactional write is initiated across one or more items
    Given name in table_status
    Given an item has been read from the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an item has been read from the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a committed transaction is cleared
    Given name in table_status
    Given an item has been read from the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a rolled-back transaction is cleared
    Given name in table_status
    Given an item has been read from the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an item has been read from the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then read throttling is toggled on or off
    Given name in table_status
    Given an item has been read from the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then write throttling is toggled on or off
    Given name in table_status
    Given an item has been read from the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table is created
    Given name in table_status
    Given an existing item has been updated in the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table finishes creating and becomes active
    Given name in table_status
    Given an existing item has been updated in the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table is deleted
    Given name in table_status
    Given an existing item has been updated in the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table deletion completes
    Given name in table_status
    Given an existing item has been updated in the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table is described
    Given name in table_status
    Given an existing item has been updated in the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then all tables are listed
    Given name in table_status
    Given an existing item has been updated in the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then an item is written to the table
    Given name in table_status
    Given an existing item has been updated in the table
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then an item is conditionally written to the table
    Given name in table_status
    Given an existing item has been updated in the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then an item is read from the table
    Given name in table_status
    Given an existing item has been updated in the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then an existing item is deleted from the table
    Given name in table_status
    Given an existing item has been updated in the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then items are queried from the table by key
    Given name in table_status
    Given an existing item has been updated in the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then all items in the table are scanned
    Given name in table_status
    Given an existing item has been updated in the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a transactional write is initiated across one or more items
    Given name in table_status
    Given an existing item has been updated in the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an existing item has been updated in the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a committed transaction is cleared
    Given name in table_status
    Given an existing item has been updated in the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a rolled-back transaction is cleared
    Given name in table_status
    Given an existing item has been updated in the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an existing item has been updated in the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then read throttling is toggled on or off
    Given name in table_status
    Given an existing item has been updated in the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then write throttling is toggled on or off
    Given name in table_status
    Given an existing item has been updated in the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table is created
    Given name in table_status
    Given an existing item has been deleted from the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table finishes creating and becomes active
    Given name in table_status
    Given an existing item has been deleted from the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table is deleted
    Given name in table_status
    Given an existing item has been deleted from the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table deletion completes
    Given name in table_status
    Given an existing item has been deleted from the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table is described
    Given name in table_status
    Given an existing item has been deleted from the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then all tables are listed
    Given name in table_status
    Given an existing item has been deleted from the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then an item is written to the table
    Given name in table_status
    Given an existing item has been deleted from the table
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then an item is conditionally written to the table
    Given name in table_status
    Given an existing item has been deleted from the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then an item is read from the table
    Given name in table_status
    Given an existing item has been deleted from the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then an existing item is updated in the table
    Given name in table_status
    Given an existing item has been deleted from the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then items are queried from the table by key
    Given name in table_status
    Given an existing item has been deleted from the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then all items in the table are scanned
    Given name in table_status
    Given an existing item has been deleted from the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a transactional write is initiated across one or more items
    Given name in table_status
    Given an existing item has been deleted from the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an existing item has been deleted from the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a committed transaction is cleared
    Given name in table_status
    Given an existing item has been deleted from the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a rolled-back transaction is cleared
    Given name in table_status
    Given an existing item has been deleted from the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an existing item has been deleted from the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then read throttling is toggled on or off
    Given name in table_status
    Given an existing item has been deleted from the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then write throttling is toggled on or off
    Given name in table_status
    Given an existing item has been deleted from the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table is created
    Given name in table_status
    Given items have been queried from the table by key
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table finishes creating and becomes active
    Given name in table_status
    Given items have been queried from the table by key
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table is deleted
    Given name in table_status
    Given items have been queried from the table by key
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table deletion completes
    Given name in table_status
    Given items have been queried from the table by key
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table is described
    Given name in table_status
    Given items have been queried from the table by key
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then all tables are listed
    Given name in table_status
    Given items have been queried from the table by key
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an item is written to the table
    Given name in table_status
    Given items have been queried from the table by key
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an item is conditionally written to the table
    Given name in table_status
    Given items have been queried from the table by key
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an item is read from the table
    Given name in table_status
    Given items have been queried from the table by key
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an existing item is updated in the table
    Given name in table_status
    Given items have been queried from the table by key
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an existing item is deleted from the table
    Given name in table_status
    Given items have been queried from the table by key
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then all items in the table are scanned
    Given name in table_status
    Given items have been queried from the table by key
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a transactional write is initiated across one or more items
    Given name in table_status
    Given items have been queried from the table by key
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a pending transaction resolves non-deterministically
    Given name in table_status
    Given items have been queried from the table by key
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a committed transaction is cleared
    Given name in table_status
    Given items have been queried from the table by key
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a rolled-back transaction is cleared
    Given name in table_status
    Given items have been queried from the table by key
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given items have been queried from the table by key
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then read throttling is toggled on or off
    Given name in table_status
    Given items have been queried from the table by key
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then write throttling is toggled on or off
    Given name in table_status
    Given items have been queried from the table by key
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table is created
    Given name in table_status
    Given all items in the table have been scanned
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table finishes creating and becomes active
    Given name in table_status
    Given all items in the table have been scanned
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table is deleted
    Given name in table_status
    Given all items in the table have been scanned
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table deletion completes
    Given name in table_status
    Given all items in the table have been scanned
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table is described
    Given name in table_status
    Given all items in the table have been scanned
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then all tables are listed
    Given name in table_status
    Given all items in the table have been scanned
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an item is written to the table
    Given name in table_status
    Given all items in the table have been scanned
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an item is conditionally written to the table
    Given name in table_status
    Given all items in the table have been scanned
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an item is read from the table
    Given name in table_status
    Given all items in the table have been scanned
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an existing item is updated in the table
    Given name in table_status
    Given all items in the table have been scanned
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an existing item is deleted from the table
    Given name in table_status
    Given all items in the table have been scanned
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then items are queried from the table by key
    Given name in table_status
    Given all items in the table have been scanned
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a transactional write is initiated across one or more items
    Given name in table_status
    Given all items in the table have been scanned
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a pending transaction resolves non-deterministically
    Given name in table_status
    Given all items in the table have been scanned
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a committed transaction is cleared
    Given name in table_status
    Given all items in the table have been scanned
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a rolled-back transaction is cleared
    Given name in table_status
    Given all items in the table have been scanned
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given all items in the table have been scanned
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then read throttling is toggled on or off
    Given name in table_status
    Given all items in the table have been scanned
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then write throttling is toggled on or off
    Given name in table_status
    Given all items in the table have been scanned
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table is created
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table finishes creating and becomes active
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table is deleted
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table deletion completes
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table is described
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then all tables are listed
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an item is written to the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an item is conditionally written to the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an item is read from the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an existing item is updated in the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an existing item is deleted from the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then items are queried from the table by key
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then all items in the table are scanned
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a committed transaction is cleared
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a rolled-back transaction is cleared
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then read throttling is toggled on or off
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then write throttling is toggled on or off
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is created
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table finishes creating and becomes active
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is deleted
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table deletion completes
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is described
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then all tables are listed
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is written to the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is conditionally written to the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is read from the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an existing item is updated in the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an existing item is deleted from the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then items are queried from the table by key
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then all items in the table are scanned
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a transactional write is initiated across one or more items
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a committed transaction is cleared
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a rolled-back transaction is cleared
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a "GSI" catches up with pending write propagation
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then read throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then write throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table is created
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table finishes creating and becomes active
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table is deleted
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table deletion completes
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table is described
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then all tables are listed
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an item is written to the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an item is conditionally written to the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an item is read from the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an existing item is updated in the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an existing item is deleted from the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then items are queried from the table by key
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then all items in the table are scanned
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a transactional write is initiated across one or more items
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a pending transaction resolves non-deterministically
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a rolled-back transaction is cleared
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a "GSI" catches up with pending write propagation
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then read throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then write throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table is created
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table finishes creating and becomes active
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table is deleted
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table deletion completes
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table is described
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then all tables are listed
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an item is written to the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an item is conditionally written to the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an item is read from the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an existing item is updated in the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an existing item is deleted from the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then items are queried from the table by key
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then all items in the table are scanned
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a transactional write is initiated across one or more items
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a pending transaction resolves non-deterministically
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a committed transaction is cleared
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a "GSI" catches up with pending write propagation
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then read throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then write throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is created
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table finishes creating and becomes active
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is deleted
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table deletion completes
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is described
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then all tables are listed
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is written to the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is conditionally written to the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is read from the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an existing item is updated in the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an existing item is deleted from the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then items are queried from the table by key
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then all items in the table are scanned
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a pending transaction resolves non-deterministically
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a committed transaction is cleared
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a rolled-back transaction is cleared
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then read throttling is toggled on or off
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then write throttling is toggled on or off
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table is created
    Given read throttling has been toggled on or off
    Given name not in table_status
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table finishes creating and becomes active
    Given read throttling has been toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table is deleted
    Given read throttling has been toggled on or off
    Given name in table_status
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table deletion completes
    Given read throttling has been toggled on or off
    Given name in table_status
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table is described
    Given read throttling has been toggled on or off
    Given name in table_status
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then all tables are listed
    Given read throttling has been toggled on or off
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an item is written to the table
    Given read throttling has been toggled on or off
    Given name in table_status
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an item is conditionally written to the table
    Given read throttling has been toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an item is read from the table
    Given read throttling has been toggled on or off
    Given name in table_status
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an existing item is updated in the table
    Given read throttling has been toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an existing item is deleted from the table
    Given read throttling has been toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then items are queried from the table by key
    Given read throttling has been toggled on or off
    Given name in table_status
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then all items in the table are scanned
    Given read throttling has been toggled on or off
    Given name in table_status
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a transactional write is initiated across one or more items
    Given read throttling has been toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a pending transaction resolves non-deterministically
    Given read throttling has been toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a committed transaction is cleared
    Given read throttling has been toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a rolled-back transaction is cleared
    Given read throttling has been toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a "GSI" catches up with pending write propagation
    Given read throttling has been toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then write throttling is toggled on or off
    Given read throttling has been toggled on or off
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table is created
    Given write throttling has been toggled on or off
    Given name not in table_status
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table finishes creating and becomes active
    Given write throttling has been toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table is deleted
    Given write throttling has been toggled on or off
    Given name in table_status
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table deletion completes
    Given write throttling has been toggled on or off
    Given name in table_status
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table is described
    Given write throttling has been toggled on or off
    Given name in table_status
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then all tables are listed
    Given write throttling has been toggled on or off
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an item is written to the table
    Given write throttling has been toggled on or off
    Given name in table_status
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an item is conditionally written to the table
    Given write throttling has been toggled on or off
    Given name in table_status
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an item is read from the table
    Given write throttling has been toggled on or off
    Given name in table_status
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an existing item is updated in the table
    Given write throttling has been toggled on or off
    Given name in table_status
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an existing item is deleted from the table
    Given write throttling has been toggled on or off
    Given name in table_status
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then items are queried from the table by key
    Given write throttling has been toggled on or off
    Given name in table_status
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then all items in the table are scanned
    Given write throttling has been toggled on or off
    Given name in table_status
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a transactional write is initiated across one or more items
    Given write throttling has been toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a pending transaction resolves non-deterministically
    Given write throttling has been toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a committed transaction is cleared
    Given write throttling has been toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a rolled-back transaction is cleared
    Given write throttling has been toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a "GSI" catches up with pending write propagation
    Given write throttling has been toggled on or off
    Given name in gsi_pending
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then read throttling is toggled on or off
    Given write throttling has been toggled on or off
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a table finishes creating and becomes active then a table is deleted
    Given name not in table_status
    Given a table has been created
    Given a table has finished creating and become active
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a table is deleted then a table deletion completes
    Given name not in table_status
    Given a table has been created
    Given a table has been deleted
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a table deletion completes then a table is described
    Given name not in table_status
    Given a table has been created
    Given a table deletion has completed
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a table is described then all tables are listed
    Given name not in table_status
    Given a table has been created
    Given a table has been described
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then all tables are listed then an item is written to the table
    Given name not in table_status
    Given a table has been created
    Given all tables have been listed
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an item is written to the table then an item is conditionally written to the table
    Given name not in table_status
    Given a table has been created
    Given an item has been written to the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an item is conditionally written to the table then an item is read from the table
    Given name not in table_status
    Given a table has been created
    Given an item has been conditionally written to the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an item is read from the table then an existing item is updated in the table
    Given name not in table_status
    Given a table has been created
    Given an item has been read from the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an existing item is updated in the table then an existing item is deleted from the table
    Given name not in table_status
    Given a table has been created
    Given an existing item has been updated in the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then an existing item is deleted from the table then items are queried from the table by key
    Given name not in table_status
    Given a table has been created
    Given an existing item has been deleted from the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then items are queried from the table by key then all items in the table are scanned
    Given name not in table_status
    Given a table has been created
    Given items have been queried from the table by key
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then all items in the table are scanned then a transactional write is initiated across one or more items
    Given name not in table_status
    Given a table has been created
    Given all items in the table have been scanned
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a transactional write is initiated across one or more items then a pending transaction resolves non-deterministically
    Given name not in table_status
    Given a table has been created
    Given a transactional write has been initiated across one or more items
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a pending transaction resolves non-deterministically then a committed transaction is cleared
    Given name not in table_status
    Given a table has been created
    Given a pending transaction has resolved non-deterministically
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a committed transaction is cleared then a rolled-back transaction is cleared
    Given name not in table_status
    Given a table has been created
    Given a committed transaction has been cleared
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a rolled-back transaction is cleared then a "GSI" catches up with pending write propagation
    Given name not in table_status
    Given a table has been created
    Given a rolled-back transaction has been cleared
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then a "GSI" catches up with pending write propagation then read throttling is toggled on or off
    Given name not in table_status
    Given a table has been created
    Given a "GSI" has caught up with pending write propagation
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then read throttling is toggled on or off then write throttling is toggled on or off
    Given name not in table_status
    Given a table has been created
    Given read throttling has been toggled on or off
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is created then write throttling is toggled on or off then a table finishes creating and becomes active
    Given name not in table_status
    Given a table has been created
    Given write throttling has been toggled on or off
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a table is created then a table deletion completes
    Given name in table_status
    Given a table has finished creating and become active
    Given a table has been created
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a table is deleted then a table is described
    Given name in table_status
    Given a table has finished creating and become active
    Given a table has been deleted
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a table deletion completes then all tables are listed
    Given name in table_status
    Given a table has finished creating and become active
    Given a table deletion has completed
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a table is described then an item is written to the table
    Given name in table_status
    Given a table has finished creating and become active
    Given a table has been described
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then all tables are listed then an item is conditionally written to the table
    Given name in table_status
    Given a table has finished creating and become active
    Given all tables have been listed
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an item is written to the table then an item is read from the table
    Given name in table_status
    Given a table has finished creating and become active
    Given an item has been written to the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an item is conditionally written to the table then an existing item is updated in the table
    Given name in table_status
    Given a table has finished creating and become active
    Given an item has been conditionally written to the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an item is read from the table then an existing item is deleted from the table
    Given name in table_status
    Given a table has finished creating and become active
    Given an item has been read from the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an existing item is updated in the table then items are queried from the table by key
    Given name in table_status
    Given a table has finished creating and become active
    Given an existing item has been updated in the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then an existing item is deleted from the table then all items in the table are scanned
    Given name in table_status
    Given a table has finished creating and become active
    Given an existing item has been deleted from the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then items are queried from the table by key then a transactional write is initiated across one or more items
    Given name in table_status
    Given a table has finished creating and become active
    Given items have been queried from the table by key
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then all items in the table are scanned then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a table has finished creating and become active
    Given all items in the table have been scanned
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a transactional write is initiated across one or more items then a committed transaction is cleared
    Given name in table_status
    Given a table has finished creating and become active
    Given a transactional write has been initiated across one or more items
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a pending transaction resolves non-deterministically then a rolled-back transaction is cleared
    Given name in table_status
    Given a table has finished creating and become active
    Given a pending transaction has resolved non-deterministically
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a committed transaction is cleared then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a table has finished creating and become active
    Given a committed transaction has been cleared
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a rolled-back transaction is cleared then read throttling is toggled on or off
    Given name in table_status
    Given a table has finished creating and become active
    Given a rolled-back transaction has been cleared
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then a "GSI" catches up with pending write propagation then write throttling is toggled on or off
    Given name in table_status
    Given a table has finished creating and become active
    Given a "GSI" has caught up with pending write propagation
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then read throttling is toggled on or off then a table is created
    Given name in table_status
    Given a table has finished creating and become active
    Given read throttling has been toggled on or off
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table finishes creating and becomes active then write throttling is toggled on or off then a table is deleted
    Given name in table_status
    Given a table has finished creating and become active
    Given write throttling has been toggled on or off
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a table is created then a table is described
    Given name in table_status
    Given a table has been deleted
    Given a table has been created
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a table finishes creating and becomes active then all tables are listed
    Given name in table_status
    Given a table has been deleted
    Given a table has finished creating and become active
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a table deletion completes then an item is written to the table
    Given name in table_status
    Given a table has been deleted
    Given a table deletion has completed
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a table is described then an item is conditionally written to the table
    Given name in table_status
    Given a table has been deleted
    Given a table has been described
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then all tables are listed then an item is read from the table
    Given name in table_status
    Given a table has been deleted
    Given all tables have been listed
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an item is written to the table then an existing item is updated in the table
    Given name in table_status
    Given a table has been deleted
    Given an item has been written to the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an item is conditionally written to the table then an existing item is deleted from the table
    Given name in table_status
    Given a table has been deleted
    Given an item has been conditionally written to the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an item is read from the table then items are queried from the table by key
    Given name in table_status
    Given a table has been deleted
    Given an item has been read from the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an existing item is updated in the table then all items in the table are scanned
    Given name in table_status
    Given a table has been deleted
    Given an existing item has been updated in the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then an existing item is deleted from the table then a transactional write is initiated across one or more items
    Given name in table_status
    Given a table has been deleted
    Given an existing item has been deleted from the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then items are queried from the table by key then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a table has been deleted
    Given items have been queried from the table by key
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then all items in the table are scanned then a committed transaction is cleared
    Given name in table_status
    Given a table has been deleted
    Given all items in the table have been scanned
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a transactional write is initiated across one or more items then a rolled-back transaction is cleared
    Given name in table_status
    Given a table has been deleted
    Given a transactional write has been initiated across one or more items
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a pending transaction resolves non-deterministically then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a table has been deleted
    Given a pending transaction has resolved non-deterministically
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a committed transaction is cleared then read throttling is toggled on or off
    Given name in table_status
    Given a table has been deleted
    Given a committed transaction has been cleared
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a rolled-back transaction is cleared then write throttling is toggled on or off
    Given name in table_status
    Given a table has been deleted
    Given a rolled-back transaction has been cleared
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then a "GSI" catches up with pending write propagation then a table is created
    Given name in table_status
    Given a table has been deleted
    Given a "GSI" has caught up with pending write propagation
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then read throttling is toggled on or off then a table finishes creating and becomes active
    Given name in table_status
    Given a table has been deleted
    Given read throttling has been toggled on or off
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is deleted then write throttling is toggled on or off then a table deletion completes
    Given name in table_status
    Given a table has been deleted
    Given write throttling has been toggled on or off
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a table is created then all tables are listed
    Given name in table_status
    Given a table deletion has completed
    Given a table has been created
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a table finishes creating and becomes active then an item is written to the table
    Given name in table_status
    Given a table deletion has completed
    Given a table has finished creating and become active
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a table is deleted then an item is conditionally written to the table
    Given name in table_status
    Given a table deletion has completed
    Given a table has been deleted
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a table is described then an item is read from the table
    Given name in table_status
    Given a table deletion has completed
    Given a table has been described
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then all tables are listed then an existing item is updated in the table
    Given name in table_status
    Given a table deletion has completed
    Given all tables have been listed
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an item is written to the table then an existing item is deleted from the table
    Given name in table_status
    Given a table deletion has completed
    Given an item has been written to the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an item is conditionally written to the table then items are queried from the table by key
    Given name in table_status
    Given a table deletion has completed
    Given an item has been conditionally written to the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an item is read from the table then all items in the table are scanned
    Given name in table_status
    Given a table deletion has completed
    Given an item has been read from the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an existing item is updated in the table then a transactional write is initiated across one or more items
    Given name in table_status
    Given a table deletion has completed
    Given an existing item has been updated in the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then an existing item is deleted from the table then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a table deletion has completed
    Given an existing item has been deleted from the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then items are queried from the table by key then a committed transaction is cleared
    Given name in table_status
    Given a table deletion has completed
    Given items have been queried from the table by key
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then all items in the table are scanned then a rolled-back transaction is cleared
    Given name in table_status
    Given a table deletion has completed
    Given all items in the table have been scanned
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a transactional write is initiated across one or more items then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a table deletion has completed
    Given a transactional write has been initiated across one or more items
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a pending transaction resolves non-deterministically then read throttling is toggled on or off
    Given name in table_status
    Given a table deletion has completed
    Given a pending transaction has resolved non-deterministically
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a committed transaction is cleared then write throttling is toggled on or off
    Given name in table_status
    Given a table deletion has completed
    Given a committed transaction has been cleared
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a rolled-back transaction is cleared then a table is created
    Given name in table_status
    Given a table deletion has completed
    Given a rolled-back transaction has been cleared
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then a "GSI" catches up with pending write propagation then a table finishes creating and becomes active
    Given name in table_status
    Given a table deletion has completed
    Given a "GSI" has caught up with pending write propagation
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then read throttling is toggled on or off then a table is deleted
    Given name in table_status
    Given a table deletion has completed
    Given read throttling has been toggled on or off
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table deletion completes then write throttling is toggled on or off then a table is described
    Given name in table_status
    Given a table deletion has completed
    Given write throttling has been toggled on or off
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a table is created then an item is written to the table
    Given name in table_status
    Given a table has been described
    Given a table has been created
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a table finishes creating and becomes active then an item is conditionally written to the table
    Given name in table_status
    Given a table has been described
    Given a table has finished creating and become active
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a table is deleted then an item is read from the table
    Given name in table_status
    Given a table has been described
    Given a table has been deleted
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a table deletion completes then an existing item is updated in the table
    Given name in table_status
    Given a table has been described
    Given a table deletion has completed
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then all tables are listed then an existing item is deleted from the table
    Given name in table_status
    Given a table has been described
    Given all tables have been listed
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an item is written to the table then items are queried from the table by key
    Given name in table_status
    Given a table has been described
    Given an item has been written to the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an item is conditionally written to the table then all items in the table are scanned
    Given name in table_status
    Given a table has been described
    Given an item has been conditionally written to the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an item is read from the table then a transactional write is initiated across one or more items
    Given name in table_status
    Given a table has been described
    Given an item has been read from the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an existing item is updated in the table then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a table has been described
    Given an existing item has been updated in the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then an existing item is deleted from the table then a committed transaction is cleared
    Given name in table_status
    Given a table has been described
    Given an existing item has been deleted from the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then items are queried from the table by key then a rolled-back transaction is cleared
    Given name in table_status
    Given a table has been described
    Given items have been queried from the table by key
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then all items in the table are scanned then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a table has been described
    Given all items in the table have been scanned
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a transactional write is initiated across one or more items then read throttling is toggled on or off
    Given name in table_status
    Given a table has been described
    Given a transactional write has been initiated across one or more items
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a pending transaction resolves non-deterministically then write throttling is toggled on or off
    Given name in table_status
    Given a table has been described
    Given a pending transaction has resolved non-deterministically
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a committed transaction is cleared then a table is created
    Given name in table_status
    Given a table has been described
    Given a committed transaction has been cleared
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a rolled-back transaction is cleared then a table finishes creating and becomes active
    Given name in table_status
    Given a table has been described
    Given a rolled-back transaction has been cleared
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then a "GSI" catches up with pending write propagation then a table is deleted
    Given name in table_status
    Given a table has been described
    Given a "GSI" has caught up with pending write propagation
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then read throttling is toggled on or off then a table deletion completes
    Given name in table_status
    Given a table has been described
    Given read throttling has been toggled on or off
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a table is described then write throttling is toggled on or off then all tables are listed
    Given name in table_status
    Given a table has been described
    Given write throttling has been toggled on or off
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table is created then an item is conditionally written to the table
    Given all tables have been listed
    Given name not in table_status
    Given a table has been created
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table finishes creating and becomes active then an item is read from the table
    Given all tables have been listed
    Given name in table_status
    Given a table has finished creating and become active
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table is deleted then an existing item is updated in the table
    Given all tables have been listed
    Given name in table_status
    Given a table has been deleted
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table deletion completes then an existing item is deleted from the table
    Given all tables have been listed
    Given name in table_status
    Given a table deletion has completed
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a table is described then items are queried from the table by key
    Given all tables have been listed
    Given name in table_status
    Given a table has been described
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an item is written to the table then all items in the table are scanned
    Given all tables have been listed
    Given name in table_status
    Given an item has been written to the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an item is conditionally written to the table then a transactional write is initiated across one or more items
    Given all tables have been listed
    Given name in table_status
    Given an item has been conditionally written to the table
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an item is read from the table then a pending transaction resolves non-deterministically
    Given all tables have been listed
    Given name in table_status
    Given an item has been read from the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an existing item is updated in the table then a committed transaction is cleared
    Given all tables have been listed
    Given name in table_status
    Given an existing item has been updated in the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then an existing item is deleted from the table then a rolled-back transaction is cleared
    Given all tables have been listed
    Given name in table_status
    Given an existing item has been deleted from the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then items are queried from the table by key then a "GSI" catches up with pending write propagation
    Given all tables have been listed
    Given name in table_status
    Given items have been queried from the table by key
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then all items in the table are scanned then read throttling is toggled on or off
    Given all tables have been listed
    Given name in table_status
    Given all items in the table have been scanned
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a transactional write is initiated across one or more items then write throttling is toggled on or off
    Given all tables have been listed
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a pending transaction resolves non-deterministically then a table is created
    Given all tables have been listed
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a committed transaction is cleared then a table finishes creating and becomes active
    Given all tables have been listed
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a rolled-back transaction is cleared then a table is deleted
    Given all tables have been listed
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then a "GSI" catches up with pending write propagation then a table deletion completes
    Given all tables have been listed
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then read throttling is toggled on or off then a table is described
    Given all tables have been listed
    Given read throttling has been toggled on or off
    Given name in table_status
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all tables are listed then write throttling is toggled on or off then an item is written to the table
    Given all tables have been listed
    Given write throttling has been toggled on or off
    Given name in table_status
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table is created then an item is read from the table
    Given name in table_status
    Given an item has been written to the table
    Given a table has been created
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table finishes creating and becomes active then an existing item is updated in the table
    Given name in table_status
    Given an item has been written to the table
    Given a table has finished creating and become active
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table is deleted then an existing item is deleted from the table
    Given name in table_status
    Given an item has been written to the table
    Given a table has been deleted
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table deletion completes then items are queried from the table by key
    Given name in table_status
    Given an item has been written to the table
    Given a table deletion has completed
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a table is described then all items in the table are scanned
    Given name in table_status
    Given an item has been written to the table
    Given a table has been described
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then all tables are listed then a transactional write is initiated across one or more items
    Given name in table_status
    Given an item has been written to the table
    Given all tables have been listed
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then an item is conditionally written to the table then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an item has been written to the table
    Given an item has been conditionally written to the table
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then an item is read from the table then a committed transaction is cleared
    Given name in table_status
    Given an item has been written to the table
    Given an item has been read from the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then an existing item is updated in the table then a rolled-back transaction is cleared
    Given name in table_status
    Given an item has been written to the table
    Given an existing item has been updated in the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then an existing item is deleted from the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an item has been written to the table
    Given an existing item has been deleted from the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then items are queried from the table by key then read throttling is toggled on or off
    Given name in table_status
    Given an item has been written to the table
    Given items have been queried from the table by key
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then all items in the table are scanned then write throttling is toggled on or off
    Given name in table_status
    Given an item has been written to the table
    Given all items in the table have been scanned
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a transactional write is initiated across one or more items then a table is created
    Given name in table_status
    Given an item has been written to the table
    Given a transactional write has been initiated across one or more items
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a pending transaction resolves non-deterministically then a table finishes creating and becomes active
    Given name in table_status
    Given an item has been written to the table
    Given a pending transaction has resolved non-deterministically
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a committed transaction is cleared then a table is deleted
    Given name in table_status
    Given an item has been written to the table
    Given a committed transaction has been cleared
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a rolled-back transaction is cleared then a table deletion completes
    Given name in table_status
    Given an item has been written to the table
    Given a rolled-back transaction has been cleared
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then a "GSI" catches up with pending write propagation then a table is described
    Given name in table_status
    Given an item has been written to the table
    Given a "GSI" has caught up with pending write propagation
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then read throttling is toggled on or off then all tables are listed
    Given name in table_status
    Given an item has been written to the table
    Given read throttling has been toggled on or off
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is written to the table then write throttling is toggled on or off then an item is conditionally written to the table
    Given name in table_status
    Given an item has been written to the table
    Given write throttling has been toggled on or off
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table is created then an existing item is updated in the table
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a table has been created
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table finishes creating and becomes active then an existing item is deleted from the table
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a table has finished creating and become active
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table is deleted then items are queried from the table by key
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a table has been deleted
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table deletion completes then all items in the table are scanned
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a table deletion has completed
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a table is described then a transactional write is initiated across one or more items
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a table has been described
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then all tables are listed then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an item has been conditionally written to the table
    Given all tables have been listed
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then an item is written to the table then a committed transaction is cleared
    Given name in table_status
    Given an item has been conditionally written to the table
    Given an item has been written to the table
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then an item is read from the table then a rolled-back transaction is cleared
    Given name in table_status
    Given an item has been conditionally written to the table
    Given an item has been read from the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then an existing item is updated in the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an item has been conditionally written to the table
    Given an existing item has been updated in the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then an existing item is deleted from the table then read throttling is toggled on or off
    Given name in table_status
    Given an item has been conditionally written to the table
    Given an existing item has been deleted from the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then items are queried from the table by key then write throttling is toggled on or off
    Given name in table_status
    Given an item has been conditionally written to the table
    Given items have been queried from the table by key
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then all items in the table are scanned then a table is created
    Given name in table_status
    Given an item has been conditionally written to the table
    Given all items in the table have been scanned
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a transactional write is initiated across one or more items then a table finishes creating and becomes active
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a transactional write has been initiated across one or more items
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a pending transaction resolves non-deterministically then a table is deleted
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a pending transaction has resolved non-deterministically
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a committed transaction is cleared then a table deletion completes
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a committed transaction has been cleared
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a rolled-back transaction is cleared then a table is described
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a rolled-back transaction has been cleared
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then a "GSI" catches up with pending write propagation then all tables are listed
    Given name in table_status
    Given an item has been conditionally written to the table
    Given a "GSI" has caught up with pending write propagation
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then read throttling is toggled on or off then an item is written to the table
    Given name in table_status
    Given an item has been conditionally written to the table
    Given read throttling has been toggled on or off
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is conditionally written to the table then write throttling is toggled on or off then an item is read from the table
    Given name in table_status
    Given an item has been conditionally written to the table
    Given write throttling has been toggled on or off
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table is created then an existing item is deleted from the table
    Given name in table_status
    Given an item has been read from the table
    Given a table has been created
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table finishes creating and becomes active then items are queried from the table by key
    Given name in table_status
    Given an item has been read from the table
    Given a table has finished creating and become active
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table is deleted then all items in the table are scanned
    Given name in table_status
    Given an item has been read from the table
    Given a table has been deleted
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table deletion completes then a transactional write is initiated across one or more items
    Given name in table_status
    Given an item has been read from the table
    Given a table deletion has completed
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a table is described then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an item has been read from the table
    Given a table has been described
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then all tables are listed then a committed transaction is cleared
    Given name in table_status
    Given an item has been read from the table
    Given all tables have been listed
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then an item is written to the table then a rolled-back transaction is cleared
    Given name in table_status
    Given an item has been read from the table
    Given an item has been written to the table
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then an item is conditionally written to the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an item has been read from the table
    Given an item has been conditionally written to the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then an existing item is updated in the table then read throttling is toggled on or off
    Given name in table_status
    Given an item has been read from the table
    Given an existing item has been updated in the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then an existing item is deleted from the table then write throttling is toggled on or off
    Given name in table_status
    Given an item has been read from the table
    Given an existing item has been deleted from the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then items are queried from the table by key then a table is created
    Given name in table_status
    Given an item has been read from the table
    Given items have been queried from the table by key
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then all items in the table are scanned then a table finishes creating and becomes active
    Given name in table_status
    Given an item has been read from the table
    Given all items in the table have been scanned
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a transactional write is initiated across one or more items then a table is deleted
    Given name in table_status
    Given an item has been read from the table
    Given a transactional write has been initiated across one or more items
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a pending transaction resolves non-deterministically then a table deletion completes
    Given name in table_status
    Given an item has been read from the table
    Given a pending transaction has resolved non-deterministically
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a committed transaction is cleared then a table is described
    Given name in table_status
    Given an item has been read from the table
    Given a committed transaction has been cleared
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a rolled-back transaction is cleared then all tables are listed
    Given name in table_status
    Given an item has been read from the table
    Given a rolled-back transaction has been cleared
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then a "GSI" catches up with pending write propagation then an item is written to the table
    Given name in table_status
    Given an item has been read from the table
    Given a "GSI" has caught up with pending write propagation
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then read throttling is toggled on or off then an item is conditionally written to the table
    Given name in table_status
    Given an item has been read from the table
    Given read throttling has been toggled on or off
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an item is read from the table then write throttling is toggled on or off then an existing item is updated in the table
    Given name in table_status
    Given an item has been read from the table
    Given write throttling has been toggled on or off
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table is created then items are queried from the table by key
    Given name in table_status
    Given an existing item has been updated in the table
    Given a table has been created
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table finishes creating and becomes active then all items in the table are scanned
    Given name in table_status
    Given an existing item has been updated in the table
    Given a table has finished creating and become active
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table is deleted then a transactional write is initiated across one or more items
    Given name in table_status
    Given an existing item has been updated in the table
    Given a table has been deleted
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table deletion completes then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an existing item has been updated in the table
    Given a table deletion has completed
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a table is described then a committed transaction is cleared
    Given name in table_status
    Given an existing item has been updated in the table
    Given a table has been described
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then all tables are listed then a rolled-back transaction is cleared
    Given name in table_status
    Given an existing item has been updated in the table
    Given all tables have been listed
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then an item is written to the table then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an existing item has been updated in the table
    Given an item has been written to the table
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then an item is conditionally written to the table then read throttling is toggled on or off
    Given name in table_status
    Given an existing item has been updated in the table
    Given an item has been conditionally written to the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then an item is read from the table then write throttling is toggled on or off
    Given name in table_status
    Given an existing item has been updated in the table
    Given an item has been read from the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then an existing item is deleted from the table then a table is created
    Given name in table_status
    Given an existing item has been updated in the table
    Given an existing item has been deleted from the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then items are queried from the table by key then a table finishes creating and becomes active
    Given name in table_status
    Given an existing item has been updated in the table
    Given items have been queried from the table by key
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then all items in the table are scanned then a table is deleted
    Given name in table_status
    Given an existing item has been updated in the table
    Given all items in the table have been scanned
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a transactional write is initiated across one or more items then a table deletion completes
    Given name in table_status
    Given an existing item has been updated in the table
    Given a transactional write has been initiated across one or more items
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a pending transaction resolves non-deterministically then a table is described
    Given name in table_status
    Given an existing item has been updated in the table
    Given a pending transaction has resolved non-deterministically
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a committed transaction is cleared then all tables are listed
    Given name in table_status
    Given an existing item has been updated in the table
    Given a committed transaction has been cleared
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a rolled-back transaction is cleared then an item is written to the table
    Given name in table_status
    Given an existing item has been updated in the table
    Given a rolled-back transaction has been cleared
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then a "GSI" catches up with pending write propagation then an item is conditionally written to the table
    Given name in table_status
    Given an existing item has been updated in the table
    Given a "GSI" has caught up with pending write propagation
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then read throttling is toggled on or off then an item is read from the table
    Given name in table_status
    Given an existing item has been updated in the table
    Given read throttling has been toggled on or off
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is updated in the table then write throttling is toggled on or off then an existing item is deleted from the table
    Given name in table_status
    Given an existing item has been updated in the table
    Given write throttling has been toggled on or off
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table is created then all items in the table are scanned
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a table has been created
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table finishes creating and becomes active then a transactional write is initiated across one or more items
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a table has finished creating and become active
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table is deleted then a pending transaction resolves non-deterministically
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a table has been deleted
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table deletion completes then a committed transaction is cleared
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a table deletion has completed
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a table is described then a rolled-back transaction is cleared
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a table has been described
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then all tables are listed then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given an existing item has been deleted from the table
    Given all tables have been listed
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then an item is written to the table then read throttling is toggled on or off
    Given name in table_status
    Given an existing item has been deleted from the table
    Given an item has been written to the table
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then an item is conditionally written to the table then write throttling is toggled on or off
    Given name in table_status
    Given an existing item has been deleted from the table
    Given an item has been conditionally written to the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then an item is read from the table then a table is created
    Given name in table_status
    Given an existing item has been deleted from the table
    Given an item has been read from the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then an existing item is updated in the table then a table finishes creating and becomes active
    Given name in table_status
    Given an existing item has been deleted from the table
    Given an existing item has been updated in the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then items are queried from the table by key then a table is deleted
    Given name in table_status
    Given an existing item has been deleted from the table
    Given items have been queried from the table by key
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then all items in the table are scanned then a table deletion completes
    Given name in table_status
    Given an existing item has been deleted from the table
    Given all items in the table have been scanned
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a transactional write is initiated across one or more items then a table is described
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a transactional write has been initiated across one or more items
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a pending transaction resolves non-deterministically then all tables are listed
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a pending transaction has resolved non-deterministically
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a committed transaction is cleared then an item is written to the table
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a committed transaction has been cleared
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a rolled-back transaction is cleared then an item is conditionally written to the table
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a rolled-back transaction has been cleared
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then a "GSI" catches up with pending write propagation then an item is read from the table
    Given name in table_status
    Given an existing item has been deleted from the table
    Given a "GSI" has caught up with pending write propagation
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then read throttling is toggled on or off then an existing item is updated in the table
    Given name in table_status
    Given an existing item has been deleted from the table
    Given read throttling has been toggled on or off
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: an existing item is deleted from the table then write throttling is toggled on or off then items are queried from the table by key
    Given name in table_status
    Given an existing item has been deleted from the table
    Given write throttling has been toggled on or off
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table is created then a transactional write is initiated across one or more items
    Given name in table_status
    Given items have been queried from the table by key
    Given a table has been created
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table finishes creating and becomes active then a pending transaction resolves non-deterministically
    Given name in table_status
    Given items have been queried from the table by key
    Given a table has finished creating and become active
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table is deleted then a committed transaction is cleared
    Given name in table_status
    Given items have been queried from the table by key
    Given a table has been deleted
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table deletion completes then a rolled-back transaction is cleared
    Given name in table_status
    Given items have been queried from the table by key
    Given a table deletion has completed
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a table is described then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given items have been queried from the table by key
    Given a table has been described
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then all tables are listed then read throttling is toggled on or off
    Given name in table_status
    Given items have been queried from the table by key
    Given all tables have been listed
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an item is written to the table then write throttling is toggled on or off
    Given name in table_status
    Given items have been queried from the table by key
    Given an item has been written to the table
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an item is conditionally written to the table then a table is created
    Given name in table_status
    Given items have been queried from the table by key
    Given an item has been conditionally written to the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an item is read from the table then a table finishes creating and becomes active
    Given name in table_status
    Given items have been queried from the table by key
    Given an item has been read from the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an existing item is updated in the table then a table is deleted
    Given name in table_status
    Given items have been queried from the table by key
    Given an existing item has been updated in the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then an existing item is deleted from the table then a table deletion completes
    Given name in table_status
    Given items have been queried from the table by key
    Given an existing item has been deleted from the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then all items in the table are scanned then a table is described
    Given name in table_status
    Given items have been queried from the table by key
    Given all items in the table have been scanned
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a transactional write is initiated across one or more items then all tables are listed
    Given name in table_status
    Given items have been queried from the table by key
    Given a transactional write has been initiated across one or more items
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a pending transaction resolves non-deterministically then an item is written to the table
    Given name in table_status
    Given items have been queried from the table by key
    Given a pending transaction has resolved non-deterministically
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a committed transaction is cleared then an item is conditionally written to the table
    Given name in table_status
    Given items have been queried from the table by key
    Given a committed transaction has been cleared
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a rolled-back transaction is cleared then an item is read from the table
    Given name in table_status
    Given items have been queried from the table by key
    Given a rolled-back transaction has been cleared
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then a "GSI" catches up with pending write propagation then an existing item is updated in the table
    Given name in table_status
    Given items have been queried from the table by key
    Given a "GSI" has caught up with pending write propagation
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then read throttling is toggled on or off then an existing item is deleted from the table
    Given name in table_status
    Given items have been queried from the table by key
    Given read throttling has been toggled on or off
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: items are queried from the table by key then write throttling is toggled on or off then all items in the table are scanned
    Given name in table_status
    Given items have been queried from the table by key
    Given write throttling has been toggled on or off
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table is created then a pending transaction resolves non-deterministically
    Given name in table_status
    Given all items in the table have been scanned
    Given a table has been created
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table finishes creating and becomes active then a committed transaction is cleared
    Given name in table_status
    Given all items in the table have been scanned
    Given a table has finished creating and become active
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table is deleted then a rolled-back transaction is cleared
    Given name in table_status
    Given all items in the table have been scanned
    Given a table has been deleted
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table deletion completes then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given all items in the table have been scanned
    Given a table deletion has completed
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a table is described then read throttling is toggled on or off
    Given name in table_status
    Given all items in the table have been scanned
    Given a table has been described
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then all tables are listed then write throttling is toggled on or off
    Given name in table_status
    Given all items in the table have been scanned
    Given all tables have been listed
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an item is written to the table then a table is created
    Given name in table_status
    Given all items in the table have been scanned
    Given an item has been written to the table
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an item is conditionally written to the table then a table finishes creating and becomes active
    Given name in table_status
    Given all items in the table have been scanned
    Given an item has been conditionally written to the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an item is read from the table then a table is deleted
    Given name in table_status
    Given all items in the table have been scanned
    Given an item has been read from the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an existing item is updated in the table then a table deletion completes
    Given name in table_status
    Given all items in the table have been scanned
    Given an existing item has been updated in the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then an existing item is deleted from the table then a table is described
    Given name in table_status
    Given all items in the table have been scanned
    Given an existing item has been deleted from the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then items are queried from the table by key then all tables are listed
    Given name in table_status
    Given all items in the table have been scanned
    Given items have been queried from the table by key
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a transactional write is initiated across one or more items then an item is written to the table
    Given name in table_status
    Given all items in the table have been scanned
    Given a transactional write has been initiated across one or more items
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a pending transaction resolves non-deterministically then an item is conditionally written to the table
    Given name in table_status
    Given all items in the table have been scanned
    Given a pending transaction has resolved non-deterministically
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a committed transaction is cleared then an item is read from the table
    Given name in table_status
    Given all items in the table have been scanned
    Given a committed transaction has been cleared
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a rolled-back transaction is cleared then an existing item is updated in the table
    Given name in table_status
    Given all items in the table have been scanned
    Given a rolled-back transaction has been cleared
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then a "GSI" catches up with pending write propagation then an existing item is deleted from the table
    Given name in table_status
    Given all items in the table have been scanned
    Given a "GSI" has caught up with pending write propagation
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then read throttling is toggled on or off then items are queried from the table by key
    Given name in table_status
    Given all items in the table have been scanned
    Given read throttling has been toggled on or off
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: all items in the table are scanned then write throttling is toggled on or off then a transactional write is initiated across one or more items
    Given name in table_status
    Given all items in the table have been scanned
    Given write throttling has been toggled on or off
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table is created then a committed transaction is cleared
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a table has been created
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table finishes creating and becomes active then a rolled-back transaction is cleared
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a table has finished creating and become active
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table is deleted then a "GSI" catches up with pending write propagation
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a table has been deleted
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table deletion completes then read throttling is toggled on or off
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a table deletion has completed
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a table is described then write throttling is toggled on or off
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a table has been described
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then all tables are listed then a table is created
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given all tables have been listed
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an item is written to the table then a table finishes creating and becomes active
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given an item has been written to the table
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an item is conditionally written to the table then a table is deleted
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given an item has been conditionally written to the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an item is read from the table then a table deletion completes
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given an item has been read from the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an existing item is updated in the table then a table is described
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given an existing item has been updated in the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then an existing item is deleted from the table then all tables are listed
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given an existing item has been deleted from the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then items are queried from the table by key then an item is written to the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given items have been queried from the table by key
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then all items in the table are scanned then an item is conditionally written to the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given all items in the table have been scanned
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a pending transaction resolves non-deterministically then an item is read from the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a pending transaction has resolved non-deterministically
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a committed transaction is cleared then an existing item is updated in the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a committed transaction has been cleared
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a rolled-back transaction is cleared then an existing item is deleted from the table
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a rolled-back transaction has been cleared
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then a "GSI" catches up with pending write propagation then items are queried from the table by key
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given a "GSI" has caught up with pending write propagation
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then read throttling is toggled on or off then all items in the table are scanned
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given read throttling has been toggled on or off
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a transactional write is initiated across one or more items then write throttling is toggled on or off then a pending transaction resolves non-deterministically
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    Given write throttling has been toggled on or off
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is created then a rolled-back transaction is cleared
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a table has been created
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table finishes creating and becomes active then a "GSI" catches up with pending write propagation
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a table has finished creating and become active
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is deleted then read throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a table has been deleted
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table deletion completes then write throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a table deletion has completed
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a table is described then a table is created
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a table has been described
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then all tables are listed then a table finishes creating and becomes active
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given all tables have been listed
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is written to the table then a table is deleted
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given an item has been written to the table
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is conditionally written to the table then a table deletion completes
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given an item has been conditionally written to the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an item is read from the table then a table is described
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given an item has been read from the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an existing item is updated in the table then all tables are listed
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given an existing item has been updated in the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then an existing item is deleted from the table then an item is written to the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given an existing item has been deleted from the table
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then items are queried from the table by key then an item is conditionally written to the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given items have been queried from the table by key
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then all items in the table are scanned then an item is read from the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given all items in the table have been scanned
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a transactional write is initiated across one or more items then an existing item is updated in the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a transactional write has been initiated across one or more items
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a committed transaction is cleared then an existing item is deleted from the table
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a committed transaction has been cleared
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a rolled-back transaction is cleared then items are queried from the table by key
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a rolled-back transaction has been cleared
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then a "GSI" catches up with pending write propagation then all items in the table are scanned
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given a "GSI" has caught up with pending write propagation
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then read throttling is toggled on or off then a transactional write is initiated across one or more items
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given read throttling has been toggled on or off
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a pending transaction resolves non-deterministically then write throttling is toggled on or off then a committed transaction is cleared
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    Given write throttling has been toggled on or off
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table is created then a "GSI" catches up with pending write propagation
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a table has been created
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table finishes creating and becomes active then read throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a table has finished creating and become active
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table is deleted then write throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a table has been deleted
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table deletion completes then a table is created
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a table deletion has completed
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a table is described then a table finishes creating and becomes active
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a table has been described
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then all tables are listed then a table is deleted
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given all tables have been listed
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an item is written to the table then a table deletion completes
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given an item has been written to the table
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an item is conditionally written to the table then a table is described
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given an item has been conditionally written to the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an item is read from the table then all tables are listed
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given an item has been read from the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an existing item is updated in the table then an item is written to the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given an existing item has been updated in the table
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then an existing item is deleted from the table then an item is conditionally written to the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given an existing item has been deleted from the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then items are queried from the table by key then an item is read from the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given items have been queried from the table by key
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then all items in the table are scanned then an existing item is updated in the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given all items in the table have been scanned
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a transactional write is initiated across one or more items then an existing item is deleted from the table
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a transactional write has been initiated across one or more items
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a pending transaction resolves non-deterministically then items are queried from the table by key
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a pending transaction has resolved non-deterministically
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a rolled-back transaction is cleared then all items in the table are scanned
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a rolled-back transaction has been cleared
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then a "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given a "GSI" has caught up with pending write propagation
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then read throttling is toggled on or off then a pending transaction resolves non-deterministically
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given read throttling has been toggled on or off
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a committed transaction is cleared then write throttling is toggled on or off then a rolled-back transaction is cleared
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    Given write throttling has been toggled on or off
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table is created then read throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a table has been created
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table finishes creating and becomes active then write throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a table has finished creating and become active
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table is deleted then a table is created
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a table has been deleted
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table deletion completes then a table finishes creating and becomes active
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a table deletion has completed
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a table is described then a table is deleted
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a table has been described
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then all tables are listed then a table deletion completes
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given all tables have been listed
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an item is written to the table then a table is described
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given an item has been written to the table
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an item is conditionally written to the table then all tables are listed
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given an item has been conditionally written to the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an item is read from the table then an item is written to the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given an item has been read from the table
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an existing item is updated in the table then an item is conditionally written to the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given an existing item has been updated in the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then an existing item is deleted from the table then an item is read from the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given an existing item has been deleted from the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then items are queried from the table by key then an existing item is updated in the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given items have been queried from the table by key
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then all items in the table are scanned then an existing item is deleted from the table
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given all items in the table have been scanned
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a transactional write is initiated across one or more items then items are queried from the table by key
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a transactional write has been initiated across one or more items
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a pending transaction resolves non-deterministically then all items in the table are scanned
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a pending transaction has resolved non-deterministically
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a committed transaction is cleared then a transactional write is initiated across one or more items
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a committed transaction has been cleared
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then a "GSI" catches up with pending write propagation then a pending transaction resolves non-deterministically
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given a "GSI" has caught up with pending write propagation
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then read throttling is toggled on or off then a committed transaction is cleared
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given read throttling has been toggled on or off
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a rolled-back transaction is cleared then write throttling is toggled on or off then a "GSI" catches up with pending write propagation
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    Given write throttling has been toggled on or off
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is created then write throttling is toggled on or off
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a table has been created
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table finishes creating and becomes active then a table is created
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a table has finished creating and become active
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is deleted then a table finishes creating and becomes active
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a table has been deleted
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table deletion completes then a table is deleted
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a table deletion has completed
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a table is described then a table deletion completes
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a table has been described
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then all tables are listed then a table is described
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given all tables have been listed
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is written to the table then all tables are listed
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given an item has been written to the table
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is conditionally written to the table then an item is written to the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given an item has been conditionally written to the table
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an item is read from the table then an item is conditionally written to the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given an item has been read from the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an existing item is updated in the table then an item is read from the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given an existing item has been updated in the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then an existing item is deleted from the table then an existing item is updated in the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given an existing item has been deleted from the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then items are queried from the table by key then an existing item is deleted from the table
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given items have been queried from the table by key
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then all items in the table are scanned then items are queried from the table by key
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given all items in the table have been scanned
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items then all items in the table are scanned
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a transactional write has been initiated across one or more items
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a pending transaction resolves non-deterministically then a transactional write is initiated across one or more items
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a pending transaction has resolved non-deterministically
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a committed transaction is cleared then a pending transaction resolves non-deterministically
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a committed transaction has been cleared
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then a rolled-back transaction is cleared then a committed transaction is cleared
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given a rolled-back transaction has been cleared
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then read throttling is toggled on or off then a rolled-back transaction is cleared
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given read throttling has been toggled on or off
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: a "GSI" catches up with pending write propagation then write throttling is toggled on or off then read throttling is toggled on or off
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    Given write throttling has been toggled on or off
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table is created then a table finishes creating and becomes active
    Given read throttling has been toggled on or off
    Given name not in table_status
    Given a table has been created
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table finishes creating and becomes active then a table is deleted
    Given read throttling has been toggled on or off
    Given name in table_status
    Given a table has finished creating and become active
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table is deleted then a table deletion completes
    Given read throttling has been toggled on or off
    Given name in table_status
    Given a table has been deleted
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table deletion completes then a table is described
    Given read throttling has been toggled on or off
    Given name in table_status
    Given a table deletion has completed
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a table is described then all tables are listed
    Given read throttling has been toggled on or off
    Given name in table_status
    Given a table has been described
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then all tables are listed then an item is written to the table
    Given read throttling has been toggled on or off
    Given all tables have been listed
    Given name in table_status
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an item is written to the table then an item is conditionally written to the table
    Given read throttling has been toggled on or off
    Given name in table_status
    Given an item has been written to the table
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an item is conditionally written to the table then an item is read from the table
    Given read throttling has been toggled on or off
    Given name in table_status
    Given an item has been conditionally written to the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an item is read from the table then an existing item is updated in the table
    Given read throttling has been toggled on or off
    Given name in table_status
    Given an item has been read from the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an existing item is updated in the table then an existing item is deleted from the table
    Given read throttling has been toggled on or off
    Given name in table_status
    Given an existing item has been updated in the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then an existing item is deleted from the table then items are queried from the table by key
    Given read throttling has been toggled on or off
    Given name in table_status
    Given an existing item has been deleted from the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then items are queried from the table by key then all items in the table are scanned
    Given read throttling has been toggled on or off
    Given name in table_status
    Given items have been queried from the table by key
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then all items in the table are scanned then a transactional write is initiated across one or more items
    Given read throttling has been toggled on or off
    Given name in table_status
    Given all items in the table have been scanned
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a transactional write is initiated across one or more items then a pending transaction resolves non-deterministically
    Given read throttling has been toggled on or off
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a pending transaction resolves non-deterministically then a committed transaction is cleared
    Given read throttling has been toggled on or off
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a committed transaction is cleared then a rolled-back transaction is cleared
    Given read throttling has been toggled on or off
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a rolled-back transaction is cleared then a "GSI" catches up with pending write propagation
    Given read throttling has been toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then a "GSI" catches up with pending write propagation then write throttling is toggled on or off
    Given read throttling has been toggled on or off
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When write throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: read throttling is toggled on or off then write throttling is toggled on or off then a table is created
    Given read throttling has been toggled on or off
    Given write throttling has been toggled on or off
    Given name not in table_status
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table is created then a table is deleted
    Given write throttling has been toggled on or off
    Given name not in table_status
    Given a table has been created
    When a table is deleted
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table finishes creating and becomes active then a table deletion completes
    Given write throttling has been toggled on or off
    Given name in table_status
    Given a table has finished creating and become active
    When a table deletion completes
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table is deleted then a table is described
    Given write throttling has been toggled on or off
    Given name in table_status
    Given a table has been deleted
    When a table is described
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table deletion completes then all tables are listed
    Given write throttling has been toggled on or off
    Given name in table_status
    Given a table deletion has completed
    When all tables are listed
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a table is described then an item is written to the table
    Given write throttling has been toggled on or off
    Given name in table_status
    Given a table has been described
    When an item is written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then all tables are listed then an item is conditionally written to the table
    Given write throttling has been toggled on or off
    Given all tables have been listed
    Given name in table_status
    When an item is conditionally written to the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an item is written to the table then an item is read from the table
    Given write throttling has been toggled on or off
    Given name in table_status
    Given an item has been written to the table
    When an item is read from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an item is conditionally written to the table then an existing item is updated in the table
    Given write throttling has been toggled on or off
    Given name in table_status
    Given an item has been conditionally written to the table
    When an existing item is updated in the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an item is read from the table then an existing item is deleted from the table
    Given write throttling has been toggled on or off
    Given name in table_status
    Given an item has been read from the table
    When an existing item is deleted from the table
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an existing item is updated in the table then items are queried from the table by key
    Given write throttling has been toggled on or off
    Given name in table_status
    Given an existing item has been updated in the table
    When items are queried from the table by key
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then an existing item is deleted from the table then all items in the table are scanned
    Given write throttling has been toggled on or off
    Given name in table_status
    Given an existing item has been deleted from the table
    When all items in the table are scanned
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then items are queried from the table by key then a transactional write is initiated across one or more items
    Given write throttling has been toggled on or off
    Given name in table_status
    Given items have been queried from the table by key
    When a transactional write is initiated across one or more items
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then all items in the table are scanned then a pending transaction resolves non-deterministically
    Given write throttling has been toggled on or off
    Given name in table_status
    Given all items in the table have been scanned
    When a pending transaction resolves non-deterministically
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a transactional write is initiated across one or more items then a committed transaction is cleared
    Given write throttling has been toggled on or off
    Given name in table_status
    Given a transactional write has been initiated across one or more items
    When a committed transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a pending transaction resolves non-deterministically then a rolled-back transaction is cleared
    Given write throttling has been toggled on or off
    Given transaction_status is '"PENDING"'
    Given a pending transaction has resolved non-deterministically
    When a rolled-back transaction is cleared
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a committed transaction is cleared then a "GSI" catches up with pending write propagation
    Given write throttling has been toggled on or off
    Given transaction_status is '"COMMITTED"'
    Given a committed transaction has been cleared
    When a "GSI" catches up with pending write propagation
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a rolled-back transaction is cleared then read throttling is toggled on or off
    Given write throttling has been toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    Given a rolled-back transaction has been cleared
    When read throttling is toggled on or off
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then a "GSI" catches up with pending write propagation then a table is created
    Given write throttling has been toggled on or off
    Given name in gsi_pending
    Given a "GSI" has caught up with pending write propagation
    When a table is created
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @sequence
  Scenario: write throttling is toggled on or off then read throttling is toggled on or off then a table finishes creating and becomes active
    Given write throttling has been toggled on or off
    Given read throttling has been toggled on or off
    Given name in table_status
    When a table finishes creating and becomes active
    Then every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction
