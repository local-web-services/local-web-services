@s3tables @generated
Feature: S3tables - A "S3 Tables" "Table"'S Policy Is Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @delete_table_policy
  Scenario: a "s3 tables" "table"'s policy is deleted
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And the "s3 tables" "table" has a policy
    When a "s3 tables" "table"'s policy is deleted
    Then the "s3 tables" "table" has no policy
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @delete_table_policy
  Scenario: a "s3 tables" "table"'s policy is deleted fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a "s3 tables" "table"'s policy is deleted
    Then the operation is rejected

  @guard @negative @delete_table_policy @lifecycle
  Scenario: a "s3 tables" "table"'s policy is deleted fails when the "s3 tables" "table" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "ACTIVE"
    When a "s3 tables" "table"'s policy is deleted
    Then the operation is rejected

  @guard @negative @delete_table_policy
  Scenario: a "s3 tables" "table"'s policy is deleted fails when the "s3 tables" "table" does not have a policy
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And the "s3 tables" "table" does not have a policy
    When a "s3 tables" "table"'s policy is deleted
    Then the operation is rejected
