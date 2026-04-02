@s3tables @generated
Feature: S3tables - An Expired S3 Tables Snapshot Is Removed From A "S3 Tables" "Table"

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @expire_snapshot
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And the "s3 tables" "table" has more than one s3 tables snapshot
    And the "s3 tables" "snapshot" existed
    And the "s3 tables" "snapshot" was "ACTIVE"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Then the "s3 tables" "snapshot" will be "DELETED" and the "s3 tables" "table" snapshot count will decrease
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @expire_snapshot
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @expire_snapshot @lifecycle
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" fails when the "s3 tables" "table" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "ACTIVE"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @expire_snapshot
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" fails when the "s3 tables" "table" had one or fewer snapshots
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And the "s3 tables" "table" had one or fewer snapshots
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @expire_snapshot
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" fails when the "s3 tables" "snapshot" did not exist
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And the "s3 tables" "table" has more than one s3 tables snapshot
    And the "s3 tables" "snapshot" did not exist
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @expire_snapshot
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" fails when the "s3 tables" "snapshot" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And the "s3 tables" "table" has more than one s3 tables snapshot
    And the "s3 tables" "snapshot" existed
    And the "s3 tables" "snapshot" was not "ACTIVE"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Then the operation is rejected
