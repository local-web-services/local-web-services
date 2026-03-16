@s3tables @generated
Feature: S3tables - A Table'S Policy Is Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @delete_table_policy
  Scenario: a table's policy is deleted
    Given the table exists
    And the table is "ACTIVE"
    And the table has a policy
    When a table's policy is deleted
    Then the table has no policy
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @delete_table_policy
  Scenario: a table's policy is deleted fails when the table does not exist
    Given the table does not exist
    When a table's policy is deleted
    Then the operation is rejected

  @standard @negative @delete_table_policy @lifecycle
  Scenario: a table's policy is deleted fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a table's policy is deleted
    Then the operation is rejected

  @standard @negative @delete_table_policy
  Scenario: a table's policy is deleted fails when the table does not have a policy
    Given the table exists
    And the table is "ACTIVE"
    And the table does not have a policy
    When a table's policy is deleted
    Then the operation is rejected
