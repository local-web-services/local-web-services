@s3tables @generated
Feature: S3tables - A Policy Is Attached To A "S3 Tables" "Table"

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @put_table_policy
  Scenario: a policy is attached to a "s3 tables" "table"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    When a policy is attached to a "s3 tables" "table"
    Then the "s3 tables" "table" has a policy
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @put_table_policy
  Scenario: a policy is attached to a "s3 tables" "table" fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a policy is attached to a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @put_table_policy @lifecycle
  Scenario: a policy is attached to a "s3 tables" "table" fails when the "s3 tables" "table" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "ACTIVE"
    When a policy is attached to a "s3 tables" "table"
    Then the operation is rejected
