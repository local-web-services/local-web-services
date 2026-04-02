@dynamodb @generated
Feature: Dynamodb - Action Sequences

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" finishes creating and becomes active
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" is deleted
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" deletion completes
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" is described
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then all "dynamodb" "table"s are listed
    Given name not in table_status
    When a "dynamodb" "table" is created
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name not in table_status
    When a "dynamodb" "table" is created
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name not in table_status
    When a "dynamodb" "table" is created
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a committed "dynamodb" "transaction" is cleared
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a rolled-back "dynamodb" "transaction" is cleared
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "GSI" catches up with pending write propagation
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then "dynamodb" "read" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then "dynamodb" "write" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" is described
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "table" is described
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "table" is described
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "table" is described
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" is described
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" is described
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" is created
    When all "dynamodb" "table"s are listed
    Given name not in table_status
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" finishes creating and becomes active
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" is deleted
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" deletion completes
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" is described
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "item" is written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "item" is read from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a transactional write is initiated across one or more items in a "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a pending "dynamodb" "transaction" resolves non-deterministically
    When all "dynamodb" "table"s are listed
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a committed "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a rolled-back "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "GSI" catches up with pending write propagation
    When all "dynamodb" "table"s are listed
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then "dynamodb" "read" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then "dynamodb" "write" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" is created
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" is deleted
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" deletion completes
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" is described
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then all "dynamodb" "table"s are listed
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is created
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is deleted
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" deletion completes
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is described
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then all "dynamodb" "table"s are listed
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is created
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" finishes creating and becomes active
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is deleted
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" deletion completes
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is described
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then all "dynamodb" "table"s are listed
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a committed "dynamodb" "transaction" is cleared
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a rolled-back "dynamodb" "transaction" is cleared
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "GSI" catches up with pending write propagation
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is created
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" finishes creating and becomes active
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is deleted
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" deletion completes
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is described
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then all "dynamodb" "table"s are listed
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a pending "dynamodb" "transaction" resolves non-deterministically
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a rolled-back "dynamodb" "transaction" is cleared
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "GSI" catches up with pending write propagation
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is created
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" finishes creating and becomes active
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is deleted
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" deletion completes
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is described
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then all "dynamodb" "table"s are listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a pending "dynamodb" "transaction" resolves non-deterministically
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a committed "dynamodb" "transaction" is cleared
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "GSI" catches up with pending write propagation
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is created
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" finishes creating and becomes active
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is deleted
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" deletion completes
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is described
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then all "dynamodb" "table"s are listed
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a committed "dynamodb" "transaction" is cleared
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a rolled-back "dynamodb" "transaction" is cleared
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "read" throttling is toggled on or off
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "write" throttling is toggled on or off
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is created
    When "dynamodb" "read" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is deleted
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" deletion completes
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is described
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then all "dynamodb" "table"s are listed
    When "dynamodb" "read" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "read" throttling is toggled on or off
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then "dynamodb" "write" throttling is toggled on or off
    When "dynamodb" "read" throttling is toggled on or off
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is created
    When "dynamodb" "write" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is deleted
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" deletion completes
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is described
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then all "dynamodb" "table"s are listed
    When "dynamodb" "write" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "write" throttling is toggled on or off
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then "dynamodb" "read" throttling is toggled on or off
    When "dynamodb" "write" throttling is toggled on or off
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is deleted
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" is deleted then a "dynamodb" "table" deletion completes
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" deletion completes then a "dynamodb" "table" is described
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" is described then all "dynamodb" "table"s are listed
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" is described
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then all "dynamodb" "table"s are listed then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "item" is read from the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name not in table_status
    When a "dynamodb" "table" is created
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name not in table_status
    When a "dynamodb" "table" is created
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name not in table_status
    When a "dynamodb" "table" is created
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a transactional write is initiated across one or more items in a "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a pending "dynamodb" "transaction" resolves non-deterministically then a committed "dynamodb" "transaction" is cleared
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a committed "dynamodb" "transaction" is cleared then a rolled-back "dynamodb" "transaction" is cleared
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a committed "dynamodb" "transaction" is cleared
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "GSI" catches up with pending write propagation
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "read" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then "dynamodb" "read" throttling is toggled on or off then "dynamodb" "write" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    When "dynamodb" "read" throttling is toggled on or off
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is created then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" finishes creating and becomes active
    Given name not in table_status
    When a "dynamodb" "table" is created
    When "dynamodb" "write" throttling is toggled on or off
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is created then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is deleted then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" deletion completes then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" deletion completes
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is described then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then all "dynamodb" "table"s are listed then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is read from the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a transactional write is initiated across one or more items in a "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a pending "dynamodb" "transaction" resolves non-deterministically then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "read" throttling is toggled on or off
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "write" throttling is toggled on or off
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "table" is created then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "table" finishes creating and becomes active then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" finishes creating and becomes active
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "table" deletion completes then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "table" is described then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then all "dynamodb" "table"s are listed then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "item" is written to the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "item" is read from the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a transactional write is initiated across one or more items in a "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a committed "dynamodb" "transaction" is cleared then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When "dynamodb" "read" throttling is toggled on or off
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is deleted then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When "dynamodb" "write" throttling is toggled on or off
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "table" is created then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is created
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "table" is deleted then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "table" is described then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then all "dynamodb" "table"s are listed then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When all "dynamodb" "table"s are listed
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "item" is written to the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "item" is read from the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a committed "dynamodb" "transaction" is cleared then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "read" throttling is toggled on or off
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" deletion completes then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "write" throttling is toggled on or off
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "table" is created then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "table" is deleted then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "table" deletion completes then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" deletion completes
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then all "dynamodb" "table"s are listed then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When all "dynamodb" "table"s are listed
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "item" is read from the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "table" is described
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" is described
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "table" is described
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "table" is described
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "table" is described
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "table" is described
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "table" is described
    When "dynamodb" "read" throttling is toggled on or off
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "table" is described then "dynamodb" "write" throttling is toggled on or off then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" is described
    When "dynamodb" "write" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" is created then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "item" is read from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" is deleted then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" deletion completes then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "table" is described then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "table" is described
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "item" is written to the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "item" is read from the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "GSI" catches up with pending write propagation
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "read" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is created
    When all "dynamodb" "table"s are listed
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" finishes creating and becomes active
    When all "dynamodb" "table"s are listed
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is deleted
    When all "dynamodb" "table"s are listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" deletion completes
    When all "dynamodb" "table"s are listed
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is described
    When all "dynamodb" "table"s are listed
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "table"s are listed then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is created then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is created
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is deleted then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" deletion completes then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is described then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is described
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then all "dynamodb" "table"s are listed then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is created then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is created
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is deleted then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" deletion completes then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is described then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is described
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then all "dynamodb" "table"s are listed then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is created then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is created
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is deleted then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" deletion completes then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is described then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is described
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then all "dynamodb" "table"s are listed then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" is created
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is described
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared then all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "item" is read from the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" is created then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" is created
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" is deleted then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" deletion completes then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" is described then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" is described
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then all "dynamodb" "table"s are listed then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is deleted
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is described
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared then all "dynamodb" "table"s are listed
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" is created then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" is created
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" is deleted then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" deletion completes then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" is described then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" is described
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then all "dynamodb" "table"s are listed then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" is deleted
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" deletion completes
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically then all "dynamodb" "table"s are listed
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" is created then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" is created
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" finishes creating and becomes active then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" finishes creating and becomes active
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" is deleted then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" is deleted
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" deletion completes then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" deletion completes
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "table" is described then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "table" is described
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then all "dynamodb" "table"s are listed then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "table"s are listed
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is written to the "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is described
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a transactional write is initiated across one or more items in a "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "GSI" catches up with pending write propagation then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "GSI" catches up with pending write propagation
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then "dynamodb" "read" throttling is toggled on or off then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "read" throttling is toggled on or off
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "item"s are queried from the "dynamodb" "table" by key then "dynamodb" "write" throttling is toggled on or off then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "write" throttling is toggled on or off
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is created then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is created
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" finishes creating and becomes active then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" finishes creating and becomes active
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is deleted then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is deleted
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" deletion completes then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "table" is described then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "table" is described
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then all "dynamodb" "table"s are listed then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When all "dynamodb" "table"s are listed
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is created
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then all "dynamodb" "table"s are listed
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a rolled-back "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a rolled-back "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "GSI" catches up with pending write propagation then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "GSI" catches up with pending write propagation
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "read" throttling is toggled on or off then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "read" throttling is toggled on or off
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "write" throttling is toggled on or off then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "write" throttling is toggled on or off
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is created then a committed "dynamodb" "transaction" is cleared
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is created
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active then a rolled-back "dynamodb" "transaction" is cleared
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is deleted then a "dynamodb" "GSI" catches up with pending write propagation
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" deletion completes then "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "table" is described then "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "table" is described
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then all "dynamodb" "table"s are listed then a "dynamodb" "table" is created
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" finishes creating and becomes active
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "table" is described
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a rolled-back "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a rolled-back "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "read" throttling is toggled on or off then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "write" throttling is toggled on or off then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is created then a rolled-back "dynamodb" "transaction" is cleared
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is created
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "GSI" catches up with pending write propagation
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is deleted then "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is deleted
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" deletion completes then "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" deletion completes
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "table" is described then a "dynamodb" "table" is created
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then all "dynamodb" "table"s are listed then a "dynamodb" "table" finishes creating and becomes active
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is deleted
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "table" is described
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a transactional write is initiated across one or more items in a "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a committed "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a committed "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then a "dynamodb" "GSI" catches up with pending write propagation then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a "dynamodb" "GSI" catches up with pending write propagation
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "read" throttling is toggled on or off then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "read" throttling is toggled on or off
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "write" throttling is toggled on or off then a committed "dynamodb" "transaction" is cleared
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "write" throttling is toggled on or off
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is created then a "dynamodb" "GSI" catches up with pending write propagation
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is created
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is deleted then "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is deleted
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" deletion completes then a "dynamodb" "table" is created
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "table" is described then a "dynamodb" "table" finishes creating and becomes active
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then all "dynamodb" "table"s are listed then a "dynamodb" "table" is deleted
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" deletion completes
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "table" is described
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "item" is read from the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a transactional write is initiated across one or more items in a "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a pending "dynamodb" "transaction" resolves non-deterministically then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a rolled-back "dynamodb" "transaction" is cleared then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a rolled-back "dynamodb" "transaction" is cleared
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then a "dynamodb" "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then "dynamodb" "read" throttling is toggled on or off then a pending "dynamodb" "transaction" resolves non-deterministically
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a committed "dynamodb" "transaction" is cleared then "dynamodb" "write" throttling is toggled on or off then a rolled-back "dynamodb" "transaction" is cleared
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is created then "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is created
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" finishes creating and becomes active then "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is deleted then a "dynamodb" "table" is created
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" deletion completes then a "dynamodb" "table" finishes creating and becomes active
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "table" is described then a "dynamodb" "table" is deleted
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then all "dynamodb" "table"s are listed then a "dynamodb" "table" deletion completes
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "table" is described
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a transactional write is initiated across one or more items in a "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a pending "dynamodb" "transaction" resolves non-deterministically then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a committed "dynamodb" "transaction" is cleared then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a committed "dynamodb" "transaction" is cleared
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "GSI" catches up with pending write propagation then a pending "dynamodb" "transaction" resolves non-deterministically
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "read" throttling is toggled on or off then a committed "dynamodb" "transaction" is cleared
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "GSI" catches up with pending write propagation
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is created then "dynamodb" "write" throttling is toggled on or off
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is created
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is created
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is deleted then a "dynamodb" "table" finishes creating and becomes active
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" deletion completes then a "dynamodb" "table" is deleted
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is described then a "dynamodb" "table" deletion completes
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is described
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then all "dynamodb" "table"s are listed then a "dynamodb" "table" is described
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When all "dynamodb" "table"s are listed
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is written to the "dynamodb" "table" then all "dynamodb" "table"s are listed
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "item" is written to the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "item" is read from the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a transactional write is initiated across one or more items in a "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a pending "dynamodb" "transaction" resolves non-deterministically then a transactional write is initiated across one or more items in a "dynamodb" "table"
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a committed "dynamodb" "transaction" is cleared then a pending "dynamodb" "transaction" resolves non-deterministically
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a committed "dynamodb" "transaction" is cleared
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then a rolled-back "dynamodb" "transaction" is cleared then a committed "dynamodb" "transaction" is cleared
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a rolled-back "dynamodb" "transaction" is cleared
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "read" throttling is toggled on or off then a rolled-back "dynamodb" "transaction" is cleared
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "read" throttling is toggled on or off
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "write" throttling is toggled on or off then "dynamodb" "read" throttling is toggled on or off
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "write" throttling is toggled on or off
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is created then a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "read" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" is deleted
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is deleted then a "dynamodb" "table" deletion completes
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" deletion completes then a "dynamodb" "table" is described
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" is described then all "dynamodb" "table"s are listed
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then all "dynamodb" "table"s are listed then a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "item" is read from the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a transactional write is initiated across one or more items in a "dynamodb" "table" then a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a pending "dynamodb" "transaction" resolves non-deterministically then a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a committed "dynamodb" "transaction" is cleared then a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a rolled-back "dynamodb" "transaction" is cleared then a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "read" throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "GSI" catches up with pending write propagation then "dynamodb" "write" throttling is toggled on or off
    When "dynamodb" "read" throttling is toggled on or off
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "write" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "read" throttling is toggled on or off then "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is created
    When "dynamodb" "read" throttling is toggled on or off
    When "dynamodb" "write" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is created then a "dynamodb" "table" is deleted
    When "dynamodb" "write" throttling is toggled on or off
    Given name not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" is deleted
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" finishes creating and becomes active then a "dynamodb" "table" deletion completes
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    When a "dynamodb" "table" deletion completes
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is deleted then a "dynamodb" "table" is described
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is deleted
    When a "dynamodb" "table" is described
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" deletion completes then all "dynamodb" "table"s are listed
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" deletion completes
    When all "dynamodb" "table"s are listed
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "table" is described then a "dynamodb" "item" is written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" is described
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then all "dynamodb" "table"s are listed then a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    When all "dynamodb" "table"s are listed
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is written to the "dynamodb" "table" then a "dynamodb" "item" is read from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is written to the "dynamodb" "table"
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is conditionally written to the "dynamodb" "table" then an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is conditionally written to the "dynamodb" "table"
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "item" is read from the "dynamodb" "table" then an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "item" is read from the "dynamodb" "table"
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then an existing "dynamodb" "item" is updated in the "dynamodb" "table" then "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is updated in the "dynamodb" "table"
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then an existing "dynamodb" "item" is deleted from the "dynamodb" "table" then all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When an existing "dynamodb" "item" is deleted from the "dynamodb" "table"
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then "dynamodb" "item"s are queried from the "dynamodb" "table" by key then a transactional write is initiated across one or more items in a "dynamodb" "table"
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When "dynamodb" "item"s are queried from the "dynamodb" "table" by key
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then all "dynamodb" "item"s in the "dynamodb" "table" are scanned then a pending "dynamodb" "transaction" resolves non-deterministically
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When all "dynamodb" "item"s in the "dynamodb" "table" are scanned
    When a pending "dynamodb" "transaction" resolves non-deterministically
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a transactional write is initiated across one or more items in a "dynamodb" "table" then a committed "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    Given name in table_status
    When a transactional write is initiated across one or more items in a "dynamodb" "table"
    When a committed "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a pending "dynamodb" "transaction" resolves non-deterministically then a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"PENDING"'
    When a pending "dynamodb" "transaction" resolves non-deterministically
    When a rolled-back "dynamodb" "transaction" is cleared
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a committed "dynamodb" "transaction" is cleared then a "dynamodb" "GSI" catches up with pending write propagation
    When "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"COMMITTED"'
    When a committed "dynamodb" "transaction" is cleared
    When a "dynamodb" "GSI" catches up with pending write propagation
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a rolled-back "dynamodb" "transaction" is cleared then "dynamodb" "read" throttling is toggled on or off
    When "dynamodb" "write" throttling is toggled on or off
    Given transaction_status is '"ROLLED_BACK"'
    When a rolled-back "dynamodb" "transaction" is cleared
    When "dynamodb" "read" throttling is toggled on or off
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then a "dynamodb" "GSI" catches up with pending write propagation then a "dynamodb" "table" is created
    When "dynamodb" "write" throttling is toggled on or off
    Given name in gsi_pending
    When a "dynamodb" "GSI" catches up with pending write propagation
    When a "dynamodb" "table" is created
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"

  @sequence
  Scenario: "dynamodb" "write" throttling is toggled on or off then "dynamodb" "read" throttling is toggled on or off then a "dynamodb" "table" finishes creating and becomes active
    When "dynamodb" "write" throttling is toggled on or off
    When "dynamodb" "read" throttling is toggled on or off
    Given name in table_status
    When a "dynamodb" "table" finishes creating and becomes active
    And every "dynamodb" "table" has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "dynamodb" "GSI" pending write count is never negative
    And "dynamodb" "transaction" status is always a valid value
    And a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"
    And "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s
    And deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"
