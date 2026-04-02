@s3tables @generated
Feature: S3tables - Maintenance Configuration Is Applied To A "S3 Tables" "Table"

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @put_table_maintenance_configuration
  Scenario: maintenance configuration is applied to a "s3 tables" "table"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    When maintenance configuration is applied to a "s3 tables" "table"
    Then compaction will be enabled for the "s3 tables" "table"
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @put_table_maintenance_configuration
  Scenario: maintenance configuration is applied to a "s3 tables" "table" fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When maintenance configuration is applied to a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @put_table_maintenance_configuration @lifecycle
  Scenario: maintenance configuration is applied to a "s3 tables" "table" fails when the "s3 tables" "table" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "ACTIVE"
    When maintenance configuration is applied to a "s3 tables" "table"
    Then the operation is rejected
