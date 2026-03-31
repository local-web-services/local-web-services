@s3tables @generated
Feature: S3tables - A "S3 Tables" "Namespace" Finishes Being Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_namespace @internal
  Scenario: a "s3 tables" "namespace" finishes being deleted
    Given the "s3 tables" "namespace" existed
    And the "s3 tables" "namespace" was "DELETING"
    When a "s3 tables" "namespace" finishes being deleted
    Then the "s3 tables" "namespace" will be deleted and all its tables will be deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @finish_deleting_namespace @internal
  Scenario: a "s3 tables" "namespace" finishes being deleted fails when the "s3 tables" "namespace" did not exist
    Given the "s3 tables" "namespace" did not exist
    When a "s3 tables" "namespace" finishes being deleted
    Then the operation is rejected

  @guard @negative @finish_deleting_namespace @internal
  Scenario: a "s3 tables" "namespace" finishes being deleted fails when the "s3 tables" "namespace" was not "DELETING"
    Given the "s3 tables" "namespace" existed
    And the "s3 tables" "namespace" was not "DELETING"
    When a "s3 tables" "namespace" finishes being deleted
    Then the operation is rejected
