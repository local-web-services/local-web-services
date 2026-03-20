@s3tables @generated
Feature: S3tables - A Namespace Is Created In A Table Bucket

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @create_namespace
  Scenario: a namespace is created in a table bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace does not already exist
    When a namespace is created in a table bucket
    Then the namespace is "ACTIVE"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @create_namespace
  Scenario: a namespace is created in a table bucket fails when the bucket does not exist
    Given the bucket does not exist
    When a namespace is created in a table bucket
    Then the operation is rejected

  @standard @negative @create_namespace @lifecycle
  Scenario: a namespace is created in a table bucket fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a namespace is created in a table bucket
    Then the operation is rejected

  @standard @negative @create_namespace
  Scenario: a namespace is created in a table bucket fails when the namespace already exists
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace already exists
    When a namespace is created in a table bucket
    Then the operation is rejected
