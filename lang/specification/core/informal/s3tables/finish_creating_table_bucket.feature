@s3tables @generated
Feature: S3tables - A Table Bucket Finishes Creating

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_creating_table_bucket @internal
  Scenario: a table bucket finishes creating
    Given the bucket exists
    And the bucket is "CREATING"
    When a table bucket finishes creating
    Then the bucket is "ACTIVE"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @finish_creating_table_bucket @internal
  Scenario: a table bucket finishes creating fails when the bucket does not exist
    Given the bucket does not exist
    When a table bucket finishes creating
    Then the operation is rejected

  @standard @negative @finish_creating_table_bucket @internal
  Scenario: a table bucket finishes creating fails when the bucket is not "CREATING"
    Given the bucket exists
    And the bucket is not "CREATING"
    When a table bucket finishes creating
    Then the operation is rejected
