@s3tables @generated
Feature: S3tables - A Table Is Created In A Namespace

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a table is created in a namespace
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace exists
    And the namespace is "ACTIVE"
    And the table does not already exist
    When a table is created in a namespace
    Then the table is in "CREATING" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @create_table
  Scenario: a table is created in a namespace fails when the bucket does not exist
    Given the bucket does not exist
    When a table is created in a namespace
    Then the operation is rejected

  @standard @negative @create_table @lifecycle @internal
  Scenario: a table is created in a namespace fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a table is created in a namespace
    Then the operation is rejected

  @standard @negative @create_table
  Scenario: a table is created in a namespace fails when the namespace does not exist
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace does not exist
    When a table is created in a namespace
    Then the operation is rejected

  @standard @negative @create_table @lifecycle @internal
  Scenario: a table is created in a namespace fails when the namespace is not "ACTIVE"
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace exists
    And the namespace is not "ACTIVE"
    When a table is created in a namespace
    Then the operation is rejected

  @standard @negative @create_table
  Scenario: a table is created in a namespace fails when the table already exists
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the namespace exists
    And the namespace is "ACTIVE"
    And the table already exists
    When a table is created in a namespace
    Then the operation is rejected
