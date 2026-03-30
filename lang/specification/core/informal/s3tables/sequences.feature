@s3tables @generated
Feature: S3tables - Action Sequences

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @sequence
  Scenario: a table bucket is created then a table bucket finishes creating
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table bucket is deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table bucket finishes being deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a namespace is created in a table bucket
    Given bname not in bucket_status
    Given a table bucket has been created
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a namespace is deleted from a table bucket
    Given bname not in bucket_status
    Given a table bucket has been created
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a namespace finishes being deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table is created in a namespace
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table finishes creating
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table is deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table finishes being deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a snapshot is created for a table
    Given bname not in bucket_status
    Given a table bucket has been created
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table's schema is evolved
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then maintenance configuration is applied to a table
    Given bname not in bucket_status
    Given a table bucket has been created
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a policy is attached to a table
    Given bname not in bucket_status
    Given a table bucket has been created
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table's policy is deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then compaction is started on a table
    Given bname not in bucket_status
    Given a table bucket has been created
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then compaction finishes on a table
    Given bname not in bucket_status
    Given a table bucket has been created
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then an expired snapshot is removed from a table
    Given bname not in bucket_status
    Given a table bucket has been created
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table bucket is created
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table bucket is deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a namespace finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table is created in a namespace
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table finishes creating
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table is deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a snapshot is created for a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table's schema is evolved
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a policy is attached to a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table's policy is deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then compaction is started on a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then compaction finishes on a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table bucket is created
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table bucket finishes creating
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a namespace finishes being deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table is created in a namespace
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table finishes creating
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table is deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table finishes being deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a snapshot is created for a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table's schema is evolved
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a policy is attached to a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table's policy is deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then compaction is started on a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then compaction finishes on a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table bucket is created
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table bucket finishes creating
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table bucket is deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a namespace finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table is created in a namespace
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table finishes creating
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table is deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a snapshot is created for a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table's schema is evolved
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a policy is attached to a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table's policy is deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then compaction is started on a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then compaction finishes on a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table bucket is created
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table bucket finishes creating
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table bucket is deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a namespace finishes being deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table is created in a namespace
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table finishes creating
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table is deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table finishes being deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a snapshot is created for a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table's schema is evolved
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a policy is attached to a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table's policy is deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then compaction is started on a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then compaction finishes on a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table bucket is created
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table bucket finishes creating
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table bucket is deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a namespace finishes being deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table is created in a namespace
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table finishes creating
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table is deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table finishes being deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a snapshot is created for a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table's schema is evolved
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a policy is attached to a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table's policy is deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then compaction is started on a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then compaction finishes on a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table bucket is created
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table bucket finishes creating
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table bucket is deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table bucket finishes being deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a namespace is created in a table bucket
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a namespace is deleted from a table bucket
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table is created in a namespace
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table finishes creating
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table is deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table finishes being deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a snapshot is created for a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table's schema is evolved
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then maintenance configuration is applied to a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a policy is attached to a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table's policy is deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then compaction is started on a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then compaction finishes on a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then an expired snapshot is removed from a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table bucket is created
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table bucket finishes creating
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table bucket is deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a namespace finishes being deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table finishes creating
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table is deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table finishes being deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a snapshot is created for a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table's schema is evolved
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a policy is attached to a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table's policy is deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then compaction is started on a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then compaction finishes on a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table bucket is created
    Given tkey in table_status
    Given a table has finished creating
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table bucket finishes creating
    Given tkey in table_status
    Given a table has finished creating
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table bucket is deleted
    Given tkey in table_status
    Given a table has finished creating
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table has finished creating
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table has finished creating
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table has finished creating
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a namespace finishes being deleted
    Given tkey in table_status
    Given a table has finished creating
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table is created in a namespace
    Given tkey in table_status
    Given a table has finished creating
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table is deleted
    Given tkey in table_status
    Given a table has finished creating
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table finishes being deleted
    Given tkey in table_status
    Given a table has finished creating
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a snapshot is created for a table
    Given tkey in table_status
    Given a table has finished creating
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table's schema is evolved
    Given tkey in table_status
    Given a table has finished creating
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table has finished creating
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a policy is attached to a table
    Given tkey in table_status
    Given a table has finished creating
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table's policy is deleted
    Given tkey in table_status
    Given a table has finished creating
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then compaction is started on a table
    Given tkey in table_status
    Given a table has finished creating
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then compaction finishes on a table
    Given tkey in table_status
    Given a table has finished creating
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table has finished creating
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table bucket is created
    Given tkey in table_status
    Given a table has been deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table bucket finishes creating
    Given tkey in table_status
    Given a table has been deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table bucket is deleted
    Given tkey in table_status
    Given a table has been deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table has been deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table has been deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table has been deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a namespace finishes being deleted
    Given tkey in table_status
    Given a table has been deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table is created in a namespace
    Given tkey in table_status
    Given a table has been deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table finishes creating
    Given tkey in table_status
    Given a table has been deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table finishes being deleted
    Given tkey in table_status
    Given a table has been deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a snapshot is created for a table
    Given tkey in table_status
    Given a table has been deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table's schema is evolved
    Given tkey in table_status
    Given a table has been deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table has been deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a policy is attached to a table
    Given tkey in table_status
    Given a table has been deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table's policy is deleted
    Given tkey in table_status
    Given a table has been deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then compaction is started on a table
    Given tkey in table_status
    Given a table has been deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then compaction finishes on a table
    Given tkey in table_status
    Given a table has been deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table has been deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table bucket is created
    Given tkey in table_status
    Given a table has finished being deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table bucket finishes creating
    Given tkey in table_status
    Given a table has finished being deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table bucket is deleted
    Given tkey in table_status
    Given a table has finished being deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table has finished being deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table has finished being deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table has finished being deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a namespace finishes being deleted
    Given tkey in table_status
    Given a table has finished being deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table is created in a namespace
    Given tkey in table_status
    Given a table has finished being deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table finishes creating
    Given tkey in table_status
    Given a table has finished being deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table is deleted
    Given tkey in table_status
    Given a table has finished being deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a snapshot is created for a table
    Given tkey in table_status
    Given a table has finished being deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table's schema is evolved
    Given tkey in table_status
    Given a table has finished being deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table has finished being deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a policy is attached to a table
    Given tkey in table_status
    Given a table has finished being deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table's policy is deleted
    Given tkey in table_status
    Given a table has finished being deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then compaction is started on a table
    Given tkey in table_status
    Given a table has finished being deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then compaction finishes on a table
    Given tkey in table_status
    Given a table has finished being deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table has finished being deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table bucket is created
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table bucket finishes creating
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table bucket is deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table bucket finishes being deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a namespace is created in a table bucket
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a namespace finishes being deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table is created in a namespace
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table finishes creating
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table is deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table finishes being deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table's schema is evolved
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a policy is attached to a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table's policy is deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then compaction is started on a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then compaction finishes on a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table bucket is created
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table bucket finishes creating
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table bucket is deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table's schema has been evolved
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table's schema has been evolved
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a namespace finishes being deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table is created in a namespace
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table finishes creating
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table is deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table finishes being deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a snapshot is created for a table
    Given tkey in table_status
    Given a table's schema has been evolved
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table's schema has been evolved
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a policy is attached to a table
    Given tkey in table_status
    Given a table's schema has been evolved
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table's policy is deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then compaction is started on a table
    Given tkey in table_status
    Given a table's schema has been evolved
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then compaction finishes on a table
    Given tkey in table_status
    Given a table's schema has been evolved
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table's schema has been evolved
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table bucket is created
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table bucket finishes creating
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table bucket is deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table bucket finishes being deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a namespace is created in a table bucket
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a namespace finishes being deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table is created in a namespace
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table finishes creating
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table is deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table finishes being deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a snapshot is created for a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table's schema is evolved
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a policy is attached to a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table's policy is deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then compaction is started on a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then compaction finishes on a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then an expired snapshot is removed from a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table bucket is created
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table bucket finishes creating
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table bucket is deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table bucket finishes being deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a namespace is created in a table bucket
    Given tkey in table_status
    Given a policy has been attached to a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a policy has been attached to a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a namespace finishes being deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table is created in a namespace
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table finishes creating
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table is deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table finishes being deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a snapshot is created for a table
    Given tkey in table_status
    Given a policy has been attached to a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table's schema is evolved
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a policy has been attached to a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table's policy is deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then compaction is started on a table
    Given tkey in table_status
    Given a policy has been attached to a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then compaction finishes on a table
    Given tkey in table_status
    Given a policy has been attached to a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a policy has been attached to a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table bucket is created
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table bucket finishes creating
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table bucket is deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table's policy has been deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table's policy has been deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a namespace finishes being deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table is created in a namespace
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table finishes creating
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table is deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table finishes being deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a snapshot is created for a table
    Given tkey in table_status
    Given a table's policy has been deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table's schema is evolved
    Given tkey in table_status
    Given a table's policy has been deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table's policy has been deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a policy is attached to a table
    Given tkey in table_status
    Given a table's policy has been deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then compaction is started on a table
    Given tkey in table_status
    Given a table's policy has been deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then compaction finishes on a table
    Given tkey in table_status
    Given a table's policy has been deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table's policy has been deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table bucket is created
    Given tkey in table_status
    Given compaction has been started on a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table bucket finishes creating
    Given tkey in table_status
    Given compaction has been started on a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table bucket is deleted
    Given tkey in table_status
    Given compaction has been started on a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table bucket finishes being deleted
    Given tkey in table_status
    Given compaction has been started on a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a namespace is created in a table bucket
    Given tkey in table_status
    Given compaction has been started on a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given compaction has been started on a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a namespace finishes being deleted
    Given tkey in table_status
    Given compaction has been started on a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table is created in a namespace
    Given tkey in table_status
    Given compaction has been started on a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table finishes creating
    Given tkey in table_status
    Given compaction has been started on a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table is deleted
    Given tkey in table_status
    Given compaction has been started on a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table finishes being deleted
    Given tkey in table_status
    Given compaction has been started on a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a snapshot is created for a table
    Given tkey in table_status
    Given compaction has been started on a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table's schema is evolved
    Given tkey in table_status
    Given compaction has been started on a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given compaction has been started on a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a policy is attached to a table
    Given tkey in table_status
    Given compaction has been started on a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table's policy is deleted
    Given tkey in table_status
    Given compaction has been started on a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then compaction finishes on a table
    Given tkey in table_status
    Given compaction has been started on a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then an expired snapshot is removed from a table
    Given tkey in table_status
    Given compaction has been started on a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table bucket is created
    Given tkey in table_status
    Given compaction has finished on a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table bucket finishes creating
    Given tkey in table_status
    Given compaction has finished on a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table bucket is deleted
    Given tkey in table_status
    Given compaction has finished on a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table bucket finishes being deleted
    Given tkey in table_status
    Given compaction has finished on a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a namespace is created in a table bucket
    Given tkey in table_status
    Given compaction has finished on a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given compaction has finished on a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a namespace finishes being deleted
    Given tkey in table_status
    Given compaction has finished on a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table is created in a namespace
    Given tkey in table_status
    Given compaction has finished on a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table finishes creating
    Given tkey in table_status
    Given compaction has finished on a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table is deleted
    Given tkey in table_status
    Given compaction has finished on a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table finishes being deleted
    Given tkey in table_status
    Given compaction has finished on a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a snapshot is created for a table
    Given tkey in table_status
    Given compaction has finished on a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table's schema is evolved
    Given tkey in table_status
    Given compaction has finished on a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given compaction has finished on a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a policy is attached to a table
    Given tkey in table_status
    Given compaction has finished on a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table's policy is deleted
    Given tkey in table_status
    Given compaction has finished on a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then compaction is started on a table
    Given tkey in table_status
    Given compaction has finished on a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then an expired snapshot is removed from a table
    Given tkey in table_status
    Given compaction has finished on a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table bucket is created
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table bucket finishes creating
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table bucket is deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table bucket finishes being deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a namespace is created in a table bucket
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a namespace finishes being deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table is created in a namespace
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table finishes creating
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table is deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table finishes being deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a snapshot is created for a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table's schema is evolved
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a policy is attached to a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table's policy is deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then compaction is started on a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then compaction finishes on a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table bucket finishes creating then a table bucket is deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table bucket has finished creating
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table bucket is deleted then a table bucket finishes being deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table bucket has been deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table bucket finishes being deleted then a namespace is created in a table bucket
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table bucket has finished being deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a namespace is created in a table bucket then a namespace is deleted from a table bucket
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a namespace has been created in a table bucket
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a namespace is deleted from a table bucket then a namespace finishes being deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a namespace has been deleted from a table bucket
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a namespace finishes being deleted then a table is created in a namespace
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a namespace has finished being deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table is created in a namespace then a table finishes creating
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table has been created in a namespace
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table finishes creating then a table is deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table has finished creating
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table is deleted then a table finishes being deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table has been deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table finishes being deleted then a snapshot is created for a table
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table has finished being deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a snapshot is created for a table then a table's schema is evolved
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a snapshot has been created for a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table's schema is evolved then maintenance configuration is applied to a table
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table's schema has been evolved
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then maintenance configuration is applied to a table then a policy is attached to a table
    Given bname not in bucket_status
    Given a table bucket has been created
    Given maintenance configuration has been applied to a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a policy is attached to a table then a table's policy is deleted
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a policy has been attached to a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then a table's policy is deleted then compaction is started on a table
    Given bname not in bucket_status
    Given a table bucket has been created
    Given a table's policy has been deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then compaction is started on a table then compaction finishes on a table
    Given bname not in bucket_status
    Given a table bucket has been created
    Given compaction has been started on a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then compaction finishes on a table then an expired snapshot is removed from a table
    Given bname not in bucket_status
    Given a table bucket has been created
    Given compaction has finished on a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is created then an expired snapshot is removed from a table then a table bucket finishes creating
    Given bname not in bucket_status
    Given a table bucket has been created
    Given an expired snapshot has been removed from a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table bucket is created then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table bucket has been created
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table bucket is deleted then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table bucket has been deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table bucket finishes being deleted then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table bucket has finished being deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a namespace is created in a table bucket then a namespace finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a namespace has been created in a table bucket
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a namespace is deleted from a table bucket then a table is created in a namespace
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a namespace has been deleted from a table bucket
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a namespace finishes being deleted then a table finishes creating
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a namespace has finished being deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table is created in a namespace then a table is deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table has been created in a namespace
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table finishes creating then a table finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table has finished creating
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table is deleted then a snapshot is created for a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table has been deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table finishes being deleted then a table's schema is evolved
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table has finished being deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a snapshot is created for a table then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a snapshot has been created for a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table's schema is evolved then a policy is attached to a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table's schema has been evolved
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then maintenance configuration is applied to a table then a table's policy is deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given maintenance configuration has been applied to a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a policy is attached to a table then compaction is started on a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a policy has been attached to a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then a table's policy is deleted then compaction finishes on a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given a table's policy has been deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then compaction is started on a table then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given compaction has been started on a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then compaction finishes on a table then a table bucket is created
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given compaction has finished on a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes creating then an expired snapshot is removed from a table then a table bucket is deleted
    Given bname in bucket_status
    Given a table bucket has finished creating
    Given an expired snapshot has been removed from a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table bucket is created then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table bucket has been created
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table bucket finishes creating then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table bucket has finished creating
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table bucket finishes being deleted then a namespace finishes being deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table bucket has finished being deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a namespace is created in a table bucket then a table is created in a namespace
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a namespace has been created in a table bucket
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a namespace is deleted from a table bucket then a table finishes creating
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a namespace has been deleted from a table bucket
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a namespace finishes being deleted then a table is deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a namespace has finished being deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table is created in a namespace then a table finishes being deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table has been created in a namespace
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table finishes creating then a snapshot is created for a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table has finished creating
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table is deleted then a table's schema is evolved
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table has been deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table finishes being deleted then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table has finished being deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a snapshot is created for a table then a policy is attached to a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a snapshot has been created for a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table's schema is evolved then a table's policy is deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table's schema has been evolved
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then maintenance configuration is applied to a table then compaction is started on a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given maintenance configuration has been applied to a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a policy is attached to a table then compaction finishes on a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a policy has been attached to a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then a table's policy is deleted then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given a table's policy has been deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then compaction is started on a table then a table bucket is created
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given compaction has been started on a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then compaction finishes on a table then a table bucket finishes creating
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given compaction has finished on a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket is deleted then an expired snapshot is removed from a table then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a table bucket has been deleted
    Given an expired snapshot has been removed from a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table bucket is created then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table bucket has been created
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table bucket finishes creating then a namespace finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table bucket has finished creating
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table bucket is deleted then a table is created in a namespace
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table bucket has been deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a namespace is created in a table bucket then a table finishes creating
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a namespace has been created in a table bucket
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a namespace is deleted from a table bucket then a table is deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a namespace has been deleted from a table bucket
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a namespace finishes being deleted then a table finishes being deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a namespace has finished being deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table is created in a namespace then a snapshot is created for a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table has been created in a namespace
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table finishes creating then a table's schema is evolved
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table has finished creating
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table is deleted then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table has been deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table finishes being deleted then a policy is attached to a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table has finished being deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a snapshot is created for a table then a table's policy is deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a snapshot has been created for a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table's schema is evolved then compaction is started on a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table's schema has been evolved
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then maintenance configuration is applied to a table then compaction finishes on a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given maintenance configuration has been applied to a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a policy is attached to a table then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a policy has been attached to a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then a table's policy is deleted then a table bucket is created
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given a table's policy has been deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then compaction is started on a table then a table bucket finishes creating
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given compaction has been started on a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then compaction finishes on a table then a table bucket is deleted
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given compaction has finished on a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table bucket finishes being deleted then an expired snapshot is removed from a table then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a table bucket has finished being deleted
    Given an expired snapshot has been removed from a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table bucket is created then a namespace finishes being deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table bucket has been created
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table bucket finishes creating then a table is created in a namespace
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table bucket has finished creating
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table bucket is deleted then a table finishes creating
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table bucket has been deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table bucket finishes being deleted then a table is deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table bucket has finished being deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a namespace is deleted from a table bucket then a table finishes being deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a namespace has been deleted from a table bucket
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a namespace finishes being deleted then a snapshot is created for a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a namespace has finished being deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table is created in a namespace then a table's schema is evolved
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table has been created in a namespace
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table finishes creating then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table has finished creating
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table is deleted then a policy is attached to a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table has been deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table finishes being deleted then a table's policy is deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table has finished being deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a snapshot is created for a table then compaction is started on a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a snapshot has been created for a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table's schema is evolved then compaction finishes on a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table's schema has been evolved
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then maintenance configuration is applied to a table then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given maintenance configuration has been applied to a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a policy is attached to a table then a table bucket is created
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a policy has been attached to a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then a table's policy is deleted then a table bucket finishes creating
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given a table's policy has been deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then compaction is started on a table then a table bucket is deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given compaction has been started on a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then compaction finishes on a table then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given compaction has finished on a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is created in a table bucket then an expired snapshot is removed from a table then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a namespace has been created in a table bucket
    Given an expired snapshot has been removed from a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table bucket is created then a table is created in a namespace
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table bucket has been created
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table bucket finishes creating then a table finishes creating
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table bucket has finished creating
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table bucket is deleted then a table is deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table bucket has been deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table bucket finishes being deleted then a table finishes being deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table bucket has finished being deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a namespace is created in a table bucket then a snapshot is created for a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a namespace has been created in a table bucket
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a namespace finishes being deleted then a table's schema is evolved
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a namespace has finished being deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table is created in a namespace then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table has been created in a namespace
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table finishes creating then a policy is attached to a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table has finished creating
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table is deleted then a table's policy is deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table has been deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table finishes being deleted then compaction is started on a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table has finished being deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a snapshot is created for a table then compaction finishes on a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a snapshot has been created for a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table's schema is evolved then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table's schema has been evolved
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then maintenance configuration is applied to a table then a table bucket is created
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given maintenance configuration has been applied to a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a policy is attached to a table then a table bucket finishes creating
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a policy has been attached to a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then a table's policy is deleted then a table bucket is deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given a table's policy has been deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then compaction is started on a table then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given compaction has been started on a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then compaction finishes on a table then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given compaction has finished on a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace is deleted from a table bucket then an expired snapshot is removed from a table then a namespace finishes being deleted
    Given bname in bucket_status
    Given a namespace has been deleted from a table bucket
    Given an expired snapshot has been removed from a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table bucket is created then a table finishes creating
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table bucket has been created
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table bucket finishes creating then a table is deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table bucket has finished creating
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table bucket is deleted then a table finishes being deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table bucket has been deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table bucket finishes being deleted then a snapshot is created for a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table bucket has finished being deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a namespace is created in a table bucket then a table's schema is evolved
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a namespace has been created in a table bucket
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a namespace is deleted from a table bucket then maintenance configuration is applied to a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a namespace has been deleted from a table bucket
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table is created in a namespace then a policy is attached to a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table has been created in a namespace
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table finishes creating then a table's policy is deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table has finished creating
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table is deleted then compaction is started on a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table has been deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table finishes being deleted then compaction finishes on a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table has finished being deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a snapshot is created for a table then an expired snapshot is removed from a table
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a snapshot has been created for a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table's schema is evolved then a table bucket is created
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table's schema has been evolved
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then maintenance configuration is applied to a table then a table bucket finishes creating
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given maintenance configuration has been applied to a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a policy is attached to a table then a table bucket is deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a policy has been attached to a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then a table's policy is deleted then a table bucket finishes being deleted
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given a table's policy has been deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then compaction is started on a table then a namespace is created in a table bucket
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given compaction has been started on a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then compaction finishes on a table then a namespace is deleted from a table bucket
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given compaction has finished on a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a namespace finishes being deleted then an expired snapshot is removed from a table then a table is created in a namespace
    Given ns_key in ns_status
    Given a namespace has finished being deleted
    Given an expired snapshot has been removed from a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table bucket is created then a table is deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table bucket has been created
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table bucket finishes creating then a table finishes being deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table bucket has finished creating
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table bucket is deleted then a snapshot is created for a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table bucket has been deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table bucket finishes being deleted then a table's schema is evolved
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table bucket has finished being deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a namespace is created in a table bucket then maintenance configuration is applied to a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a namespace has been created in a table bucket
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a namespace is deleted from a table bucket then a policy is attached to a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a namespace has been deleted from a table bucket
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a namespace finishes being deleted then a table's policy is deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a namespace has finished being deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table finishes creating then compaction is started on a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table has finished creating
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table is deleted then compaction finishes on a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table has been deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table finishes being deleted then an expired snapshot is removed from a table
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table has finished being deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a snapshot is created for a table then a table bucket is created
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a snapshot has been created for a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table's schema is evolved then a table bucket finishes creating
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table's schema has been evolved
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then maintenance configuration is applied to a table then a table bucket is deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given maintenance configuration has been applied to a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a policy is attached to a table then a table bucket finishes being deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a policy has been attached to a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then a table's policy is deleted then a namespace is created in a table bucket
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given a table's policy has been deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then compaction is started on a table then a namespace is deleted from a table bucket
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given compaction has been started on a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then compaction finishes on a table then a namespace finishes being deleted
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given compaction has finished on a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is created in a namespace then an expired snapshot is removed from a table then a table finishes creating
    Given bname in bucket_status
    Given a table has been created in a namespace
    Given an expired snapshot has been removed from a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table bucket is created then a table finishes being deleted
    Given tkey in table_status
    Given a table has finished creating
    Given a table bucket has been created
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table bucket finishes creating then a snapshot is created for a table
    Given tkey in table_status
    Given a table has finished creating
    Given a table bucket has finished creating
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table bucket is deleted then a table's schema is evolved
    Given tkey in table_status
    Given a table has finished creating
    Given a table bucket has been deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table bucket finishes being deleted then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table has finished creating
    Given a table bucket has finished being deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a namespace is created in a table bucket then a policy is attached to a table
    Given tkey in table_status
    Given a table has finished creating
    Given a namespace has been created in a table bucket
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a namespace is deleted from a table bucket then a table's policy is deleted
    Given tkey in table_status
    Given a table has finished creating
    Given a namespace has been deleted from a table bucket
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a namespace finishes being deleted then compaction is started on a table
    Given tkey in table_status
    Given a table has finished creating
    Given a namespace has finished being deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table is created in a namespace then compaction finishes on a table
    Given tkey in table_status
    Given a table has finished creating
    Given a table has been created in a namespace
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table is deleted then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table has finished creating
    Given a table has been deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table finishes being deleted then a table bucket is created
    Given tkey in table_status
    Given a table has finished creating
    Given a table has finished being deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a snapshot is created for a table then a table bucket finishes creating
    Given tkey in table_status
    Given a table has finished creating
    Given a snapshot has been created for a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table's schema is evolved then a table bucket is deleted
    Given tkey in table_status
    Given a table has finished creating
    Given a table's schema has been evolved
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then maintenance configuration is applied to a table then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table has finished creating
    Given maintenance configuration has been applied to a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a policy is attached to a table then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table has finished creating
    Given a policy has been attached to a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then a table's policy is deleted then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table has finished creating
    Given a table's policy has been deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then compaction is started on a table then a namespace finishes being deleted
    Given tkey in table_status
    Given a table has finished creating
    Given compaction has been started on a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then compaction finishes on a table then a table is created in a namespace
    Given tkey in table_status
    Given a table has finished creating
    Given compaction has finished on a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes creating then an expired snapshot is removed from a table then a table is deleted
    Given tkey in table_status
    Given a table has finished creating
    Given an expired snapshot has been removed from a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table bucket is created then a snapshot is created for a table
    Given tkey in table_status
    Given a table has been deleted
    Given a table bucket has been created
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table bucket finishes creating then a table's schema is evolved
    Given tkey in table_status
    Given a table has been deleted
    Given a table bucket has finished creating
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table bucket is deleted then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table has been deleted
    Given a table bucket has been deleted
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table bucket finishes being deleted then a policy is attached to a table
    Given tkey in table_status
    Given a table has been deleted
    Given a table bucket has finished being deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a namespace is created in a table bucket then a table's policy is deleted
    Given tkey in table_status
    Given a table has been deleted
    Given a namespace has been created in a table bucket
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a namespace is deleted from a table bucket then compaction is started on a table
    Given tkey in table_status
    Given a table has been deleted
    Given a namespace has been deleted from a table bucket
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a namespace finishes being deleted then compaction finishes on a table
    Given tkey in table_status
    Given a table has been deleted
    Given a namespace has finished being deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table is created in a namespace then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table has been deleted
    Given a table has been created in a namespace
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table finishes creating then a table bucket is created
    Given tkey in table_status
    Given a table has been deleted
    Given a table has finished creating
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table finishes being deleted then a table bucket finishes creating
    Given tkey in table_status
    Given a table has been deleted
    Given a table has finished being deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a snapshot is created for a table then a table bucket is deleted
    Given tkey in table_status
    Given a table has been deleted
    Given a snapshot has been created for a table
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table's schema is evolved then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table has been deleted
    Given a table's schema has been evolved
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then maintenance configuration is applied to a table then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table has been deleted
    Given maintenance configuration has been applied to a table
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a policy is attached to a table then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table has been deleted
    Given a policy has been attached to a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then a table's policy is deleted then a namespace finishes being deleted
    Given tkey in table_status
    Given a table has been deleted
    Given a table's policy has been deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then compaction is started on a table then a table is created in a namespace
    Given tkey in table_status
    Given a table has been deleted
    Given compaction has been started on a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then compaction finishes on a table then a table finishes creating
    Given tkey in table_status
    Given a table has been deleted
    Given compaction has finished on a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table is deleted then an expired snapshot is removed from a table then a table finishes being deleted
    Given tkey in table_status
    Given a table has been deleted
    Given an expired snapshot has been removed from a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table bucket is created then a table's schema is evolved
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table bucket has been created
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table bucket finishes creating then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table bucket has finished creating
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table bucket is deleted then a policy is attached to a table
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table bucket has been deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table bucket finishes being deleted then a table's policy is deleted
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table bucket has finished being deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a namespace is created in a table bucket then compaction is started on a table
    Given tkey in table_status
    Given a table has finished being deleted
    Given a namespace has been created in a table bucket
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a namespace is deleted from a table bucket then compaction finishes on a table
    Given tkey in table_status
    Given a table has finished being deleted
    Given a namespace has been deleted from a table bucket
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a namespace finishes being deleted then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table has finished being deleted
    Given a namespace has finished being deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table is created in a namespace then a table bucket is created
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table has been created in a namespace
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table finishes creating then a table bucket finishes creating
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table has finished creating
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table is deleted then a table bucket is deleted
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table has been deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a snapshot is created for a table then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table has finished being deleted
    Given a snapshot has been created for a table
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table's schema is evolved then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table's schema has been evolved
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then maintenance configuration is applied to a table then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table has finished being deleted
    Given maintenance configuration has been applied to a table
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a policy is attached to a table then a namespace finishes being deleted
    Given tkey in table_status
    Given a table has finished being deleted
    Given a policy has been attached to a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then a table's policy is deleted then a table is created in a namespace
    Given tkey in table_status
    Given a table has finished being deleted
    Given a table's policy has been deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then compaction is started on a table then a table finishes creating
    Given tkey in table_status
    Given a table has finished being deleted
    Given compaction has been started on a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then compaction finishes on a table then a table is deleted
    Given tkey in table_status
    Given a table has finished being deleted
    Given compaction has finished on a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table finishes being deleted then an expired snapshot is removed from a table then a snapshot is created for a table
    Given tkey in table_status
    Given a table has finished being deleted
    Given an expired snapshot has been removed from a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table bucket is created then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table bucket has been created
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table bucket finishes creating then a policy is attached to a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table bucket has finished creating
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table bucket is deleted then a table's policy is deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table bucket has been deleted
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table bucket finishes being deleted then compaction is started on a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table bucket has finished being deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a namespace is created in a table bucket then compaction finishes on a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a namespace has been created in a table bucket
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a namespace is deleted from a table bucket then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a namespace has been deleted from a table bucket
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a namespace finishes being deleted then a table bucket is created
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a namespace has finished being deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table is created in a namespace then a table bucket finishes creating
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table has been created in a namespace
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table finishes creating then a table bucket is deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table has finished creating
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table is deleted then a table bucket finishes being deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table has been deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table finishes being deleted then a namespace is created in a table bucket
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table has finished being deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table's schema is evolved then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table's schema has been evolved
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then maintenance configuration is applied to a table then a namespace finishes being deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given maintenance configuration has been applied to a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a policy is attached to a table then a table is created in a namespace
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a policy has been attached to a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then a table's policy is deleted then a table finishes creating
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given a table's policy has been deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then compaction is started on a table then a table is deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given compaction has been started on a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then compaction finishes on a table then a table finishes being deleted
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given compaction has finished on a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a snapshot is created for a table then an expired snapshot is removed from a table then a table's schema is evolved
    Given tkey in table_status
    Given a snapshot has been created for a table
    Given an expired snapshot has been removed from a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table bucket is created then a policy is attached to a table
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table bucket has been created
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table bucket finishes creating then a table's policy is deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table bucket has finished creating
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table bucket is deleted then compaction is started on a table
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table bucket has been deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table bucket finishes being deleted then compaction finishes on a table
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table bucket has finished being deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a namespace is created in a table bucket then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a namespace has been created in a table bucket
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a namespace is deleted from a table bucket then a table bucket is created
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a namespace has been deleted from a table bucket
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a namespace finishes being deleted then a table bucket finishes creating
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a namespace has finished being deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table is created in a namespace then a table bucket is deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table has been created in a namespace
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table finishes creating then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table has finished creating
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table is deleted then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table has been deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table finishes being deleted then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table has finished being deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a snapshot is created for a table then a namespace finishes being deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a snapshot has been created for a table
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then maintenance configuration is applied to a table then a table is created in a namespace
    Given tkey in table_status
    Given a table's schema has been evolved
    Given maintenance configuration has been applied to a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a policy is attached to a table then a table finishes creating
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a policy has been attached to a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then a table's policy is deleted then a table is deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    Given a table's policy has been deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then compaction is started on a table then a table finishes being deleted
    Given tkey in table_status
    Given a table's schema has been evolved
    Given compaction has been started on a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then compaction finishes on a table then a snapshot is created for a table
    Given tkey in table_status
    Given a table's schema has been evolved
    Given compaction has finished on a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's schema is evolved then an expired snapshot is removed from a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table's schema has been evolved
    Given an expired snapshot has been removed from a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table bucket is created then a table's policy is deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table bucket has been created
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table bucket finishes creating then compaction is started on a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table bucket has finished creating
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table bucket is deleted then compaction finishes on a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table bucket has been deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table bucket finishes being deleted then an expired snapshot is removed from a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table bucket has finished being deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a namespace is created in a table bucket then a table bucket is created
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a namespace has been created in a table bucket
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a namespace is deleted from a table bucket then a table bucket finishes creating
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a namespace has been deleted from a table bucket
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a namespace finishes being deleted then a table bucket is deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a namespace has finished being deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table is created in a namespace then a table bucket finishes being deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table has been created in a namespace
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table finishes creating then a namespace is created in a table bucket
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table has finished creating
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table is deleted then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table has been deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table finishes being deleted then a namespace finishes being deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table has finished being deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a snapshot is created for a table then a table is created in a namespace
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a snapshot has been created for a table
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table's schema is evolved then a table finishes creating
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table's schema has been evolved
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a policy is attached to a table then a table is deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a policy has been attached to a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then a table's policy is deleted then a table finishes being deleted
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given a table's policy has been deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then compaction is started on a table then a snapshot is created for a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given compaction has been started on a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then compaction finishes on a table then a table's schema is evolved
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given compaction has finished on a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a table then an expired snapshot is removed from a table then a policy is attached to a table
    Given tkey in table_status
    Given maintenance configuration has been applied to a table
    Given an expired snapshot has been removed from a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table bucket is created then compaction is started on a table
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table bucket has been created
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table bucket finishes creating then compaction finishes on a table
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table bucket has finished creating
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table bucket is deleted then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table bucket has been deleted
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table bucket finishes being deleted then a table bucket is created
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table bucket has finished being deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a namespace is created in a table bucket then a table bucket finishes creating
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a namespace has been created in a table bucket
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a namespace is deleted from a table bucket then a table bucket is deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a namespace has been deleted from a table bucket
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a namespace finishes being deleted then a table bucket finishes being deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a namespace has finished being deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table is created in a namespace then a namespace is created in a table bucket
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table has been created in a namespace
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table finishes creating then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table has finished creating
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table is deleted then a namespace finishes being deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table has been deleted
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table finishes being deleted then a table is created in a namespace
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table has finished being deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a snapshot is created for a table then a table finishes creating
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a snapshot has been created for a table
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table's schema is evolved then a table is deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table's schema has been evolved
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then maintenance configuration is applied to a table then a table finishes being deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    Given maintenance configuration has been applied to a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then a table's policy is deleted then a snapshot is created for a table
    Given tkey in table_status
    Given a policy has been attached to a table
    Given a table's policy has been deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then compaction is started on a table then a table's schema is evolved
    Given tkey in table_status
    Given a policy has been attached to a table
    Given compaction has been started on a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then compaction finishes on a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a policy has been attached to a table
    Given compaction has finished on a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a table then an expired snapshot is removed from a table then a table's policy is deleted
    Given tkey in table_status
    Given a policy has been attached to a table
    Given an expired snapshot has been removed from a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table bucket is created then compaction finishes on a table
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table bucket has been created
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table bucket finishes creating then an expired snapshot is removed from a table
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table bucket has finished creating
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table bucket is deleted then a table bucket is created
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table bucket has been deleted
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table bucket finishes being deleted then a table bucket finishes creating
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table bucket has finished being deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a namespace is created in a table bucket then a table bucket is deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a namespace has been created in a table bucket
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a namespace is deleted from a table bucket then a table bucket finishes being deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a namespace has been deleted from a table bucket
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a namespace finishes being deleted then a namespace is created in a table bucket
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a namespace has finished being deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table is created in a namespace then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table has been created in a namespace
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table finishes creating then a namespace finishes being deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table has finished creating
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table is deleted then a table is created in a namespace
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table has been deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table finishes being deleted then a table finishes creating
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table has finished being deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a snapshot is created for a table then a table is deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a snapshot has been created for a table
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a table's schema is evolved then a table finishes being deleted
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a table's schema has been evolved
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then maintenance configuration is applied to a table then a snapshot is created for a table
    Given tkey in table_status
    Given a table's policy has been deleted
    Given maintenance configuration has been applied to a table
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then a policy is attached to a table then a table's schema is evolved
    Given tkey in table_status
    Given a table's policy has been deleted
    Given a policy has been attached to a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then compaction is started on a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given a table's policy has been deleted
    Given compaction has been started on a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then compaction finishes on a table then a policy is attached to a table
    Given tkey in table_status
    Given a table's policy has been deleted
    Given compaction has finished on a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a table's policy is deleted then an expired snapshot is removed from a table then compaction is started on a table
    Given tkey in table_status
    Given a table's policy has been deleted
    Given an expired snapshot has been removed from a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table bucket is created then an expired snapshot is removed from a table
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table bucket has been created
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table bucket finishes creating then a table bucket is created
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table bucket has finished creating
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table bucket is deleted then a table bucket finishes creating
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table bucket has been deleted
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table bucket finishes being deleted then a table bucket is deleted
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table bucket has finished being deleted
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a namespace is created in a table bucket then a table bucket finishes being deleted
    Given tkey in table_status
    Given compaction has been started on a table
    Given a namespace has been created in a table bucket
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a namespace is deleted from a table bucket then a namespace is created in a table bucket
    Given tkey in table_status
    Given compaction has been started on a table
    Given a namespace has been deleted from a table bucket
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a namespace finishes being deleted then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given compaction has been started on a table
    Given a namespace has finished being deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table is created in a namespace then a namespace finishes being deleted
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table has been created in a namespace
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table finishes creating then a table is created in a namespace
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table has finished creating
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table is deleted then a table finishes creating
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table has been deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table finishes being deleted then a table is deleted
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table has finished being deleted
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a snapshot is created for a table then a table finishes being deleted
    Given tkey in table_status
    Given compaction has been started on a table
    Given a snapshot has been created for a table
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table's schema is evolved then a snapshot is created for a table
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table's schema has been evolved
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then maintenance configuration is applied to a table then a table's schema is evolved
    Given tkey in table_status
    Given compaction has been started on a table
    Given maintenance configuration has been applied to a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a policy is attached to a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given compaction has been started on a table
    Given a policy has been attached to a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then a table's policy is deleted then a policy is attached to a table
    Given tkey in table_status
    Given compaction has been started on a table
    Given a table's policy has been deleted
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then compaction finishes on a table then a table's policy is deleted
    Given tkey in table_status
    Given compaction has been started on a table
    Given compaction has finished on a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a table then an expired snapshot is removed from a table then compaction finishes on a table
    Given tkey in table_status
    Given compaction has been started on a table
    Given an expired snapshot has been removed from a table
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table bucket is created then a table bucket finishes creating
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table bucket has been created
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table bucket finishes creating then a table bucket is deleted
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table bucket has finished creating
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table bucket is deleted then a table bucket finishes being deleted
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table bucket has been deleted
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table bucket finishes being deleted then a namespace is created in a table bucket
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table bucket has finished being deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a namespace is created in a table bucket then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given compaction has finished on a table
    Given a namespace has been created in a table bucket
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a namespace is deleted from a table bucket then a namespace finishes being deleted
    Given tkey in table_status
    Given compaction has finished on a table
    Given a namespace has been deleted from a table bucket
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a namespace finishes being deleted then a table is created in a namespace
    Given tkey in table_status
    Given compaction has finished on a table
    Given a namespace has finished being deleted
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table is created in a namespace then a table finishes creating
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table has been created in a namespace
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table finishes creating then a table is deleted
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table has finished creating
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table is deleted then a table finishes being deleted
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table has been deleted
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table finishes being deleted then a snapshot is created for a table
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table has finished being deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a snapshot is created for a table then a table's schema is evolved
    Given tkey in table_status
    Given compaction has finished on a table
    Given a snapshot has been created for a table
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table's schema is evolved then maintenance configuration is applied to a table
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table's schema has been evolved
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then maintenance configuration is applied to a table then a policy is attached to a table
    Given tkey in table_status
    Given compaction has finished on a table
    Given maintenance configuration has been applied to a table
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a policy is attached to a table then a table's policy is deleted
    Given tkey in table_status
    Given compaction has finished on a table
    Given a policy has been attached to a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then a table's policy is deleted then compaction is started on a table
    Given tkey in table_status
    Given compaction has finished on a table
    Given a table's policy has been deleted
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then compaction is started on a table then an expired snapshot is removed from a table
    Given tkey in table_status
    Given compaction has finished on a table
    Given compaction has been started on a table
    When an expired snapshot is removed from a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a table then an expired snapshot is removed from a table then a table bucket is created
    Given tkey in table_status
    Given compaction has finished on a table
    Given an expired snapshot has been removed from a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table bucket is created then a table bucket is deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table bucket has been created
    When a table bucket is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table bucket finishes creating then a table bucket finishes being deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table bucket has finished creating
    When a table bucket finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table bucket is deleted then a namespace is created in a table bucket
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table bucket has been deleted
    When a namespace is created in a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table bucket finishes being deleted then a namespace is deleted from a table bucket
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table bucket has finished being deleted
    When a namespace is deleted from a table bucket
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a namespace is created in a table bucket then a namespace finishes being deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a namespace has been created in a table bucket
    When a namespace finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a namespace is deleted from a table bucket then a table is created in a namespace
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a namespace has been deleted from a table bucket
    When a table is created in a namespace
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a namespace finishes being deleted then a table finishes creating
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a namespace has finished being deleted
    When a table finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table is created in a namespace then a table is deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table has been created in a namespace
    When a table is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table finishes creating then a table finishes being deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table has finished creating
    When a table finishes being deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table is deleted then a snapshot is created for a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table has been deleted
    When a snapshot is created for a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table finishes being deleted then a table's schema is evolved
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table has finished being deleted
    When a table's schema is evolved
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a snapshot is created for a table then maintenance configuration is applied to a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a snapshot has been created for a table
    When maintenance configuration is applied to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table's schema is evolved then a policy is attached to a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table's schema has been evolved
    When a policy is attached to a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then maintenance configuration is applied to a table then a table's policy is deleted
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given maintenance configuration has been applied to a table
    When a table's policy is deleted
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a policy is attached to a table then compaction is started on a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a policy has been attached to a table
    When compaction is started on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then a table's policy is deleted then compaction finishes on a table
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given a table's policy has been deleted
    When compaction finishes on a table
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then compaction is started on a table then a table bucket is created
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given compaction has been started on a table
    When a table bucket is created
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired snapshot is removed from a table then compaction finishes on a table then a table bucket finishes creating
    Given tkey in table_status
    Given an expired snapshot has been removed from a table
    Given compaction has finished on a table
    When a table bucket finishes creating
    Then a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one
