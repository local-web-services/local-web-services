@s3tables @generated
Feature: S3tables - A "S3 Tables" "Snapshot" Is Created For A "S3 Tables" "Table"

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @create_snapshot
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And the "s3 tables" "snapshot" did not already exist
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Then the "s3 tables" "SNAPSHOT" will be "ACTIVE" and the "s3 tables" "table" s3 tables snapshot count will increase
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @create_snapshot
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @create_snapshot @lifecycle
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" fails when the "s3 tables" "table" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "ACTIVE"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @create_snapshot
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" fails when the "s3 tables" "snapshot" already existed
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And the "s3 tables" "snapshot" already existed
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Then the operation is rejected
