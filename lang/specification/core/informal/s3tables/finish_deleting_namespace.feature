@s3tables @generated
Feature: S3tables - A Namespace Finishes Being Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_namespace @internal
  Scenario: a namespace finishes being deleted
    Given the namespace exists
    And the namespace is "DELETING"
    When a namespace finishes being deleted
    Then the namespace is "DELETED" and all its tables are "DELETED"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @finish_deleting_namespace @internal
  Scenario: a namespace finishes being deleted fails when the namespace does not exist
    Given the namespace does not exist
    When a namespace finishes being deleted
    Then the operation is rejected

  @guard @negative @finish_deleting_namespace @internal
  Scenario: a namespace finishes being deleted fails when the namespace is not "DELETING"
    Given the namespace exists
    And the namespace is not "DELETING"
    When a namespace finishes being deleted
    Then the operation is rejected
