@s3tables @generated
Feature: S3tables - A Policy Is Attached To A Table

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @put_table_policy
  Scenario: a policy is attached to a table
    Given the table exists
    And the table is "ACTIVE"
    When a policy is attached to a table
    Then the table has a policy
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @put_table_policy
  Scenario: a policy is attached to a table fails when the table does not exist
    Given the table does not exist
    When a policy is attached to a table
    Then the operation is rejected

  @standard @negative @put_table_policy @lifecycle @internal
  Scenario: a policy is attached to a table fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a policy is attached to a table
    Then the operation is rejected
