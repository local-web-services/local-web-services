@s3tables @generated
Feature: S3tables - A Namespace Is Deleted From A Table Bucket

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @delete_namespace
  Scenario: a namespace is deleted from a table bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace exists
    And the namespace is "ACTIVE"
    And the namespace has no active tables
    When a namespace is deleted from a table bucket
    Then the namespace enters "DELETING" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @delete_namespace
  Scenario: a namespace is deleted from a table bucket fails when the bucket does not exist
    Given the bucket does not exist
    When a namespace is deleted from a table bucket
    Then the operation is rejected

  @guard @negative @delete_namespace @lifecycle
  Scenario: a namespace is deleted from a table bucket fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a namespace is deleted from a table bucket
    Then the operation is rejected

  @guard @negative @delete_namespace
  Scenario: a namespace is deleted from a table bucket fails when the namespace does not exist
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace does not exist
    When a namespace is deleted from a table bucket
    Then the operation is rejected

  @guard @negative @delete_namespace @lifecycle
  Scenario: a namespace is deleted from a table bucket fails when the namespace is not "ACTIVE"
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace exists
    And the namespace is not "ACTIVE"
    When a namespace is deleted from a table bucket
    Then the operation is rejected

  @guard @negative @delete_namespace
  Scenario: a namespace is deleted from a table bucket fails when the namespace has active tables
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace exists
    And the namespace is "ACTIVE"
    And the namespace has active tables
    When a namespace is deleted from a table bucket
    Then the operation is rejected
