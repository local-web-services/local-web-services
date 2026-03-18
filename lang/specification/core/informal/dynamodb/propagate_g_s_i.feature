@dynamodb @generated
Feature: Dynamodb - A Gsi Catches Up With Pending Write Propagation

  # Generated from FizzBee spec: dynamodb.fizz
  # Safety invariants: TableStatusValid, GsiPendingNonNegative, TransactionStatusValid, TransactionTableExists, ItemsOnlyInActiveTables, DeletedTableNotWritable

  Background:
    Given the system is initialized

  @minimal @happy @propagate_g_s_i @internal
  Scenario: a "GSI" catches up with pending write propagation
    Given the table has pending "GSI" propagation
    And there are writes pending propagation to the "GSI"
    When a "GSI" catches up with pending write propagation
    Then the "GSI" is consistent with the table
    And every table has a valid status ("CREATING", "ACTIVE", or "DELETED")
    And "GSI" pending write count is never negative
    And transaction status is always a valid value
    And a pending transaction always references an existing table
    And items only exist in non-deleted tables
    And deleted tables are never the target of a pending transaction

  @standard @negative @propagate_g_s_i @internal
  Scenario: a "GSI" catches up with pending write propagation fails when the table does not have pending "GSI" propagation
    Given the table does not have pending "GSI" propagation
    When a "GSI" catches up with pending write propagation
    Then the operation is rejected

  @standard @negative @propagate_g_s_i @internal
  Scenario: a "GSI" catches up with pending write propagation fails when there are no writes pending propagation to the "GSI"
    Given the table has pending "GSI" propagation
    And there are no writes pending propagation to the "GSI"
    When a "GSI" catches up with pending write propagation
    Then the operation is rejected
