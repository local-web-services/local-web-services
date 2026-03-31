@s3tables @generated
Feature: S3tables - Action Sequences

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" finishes being deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" finishes creating
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" is deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" finishes being deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table"'s schema is evolved
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then maintenance configuration is applied to a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a policy is attached to a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table"'s policy is deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then compaction is started on a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then compaction finishes on a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket is created
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" finishes creating
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" is deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" finishes being deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table"'s schema is evolved
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a policy is attached to a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table"'s policy is deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then compaction is started on a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then compaction finishes on a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" finishes being deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" finishes creating
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" finishes creating then a "s3 tables" "table" is deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" is deleted then a "s3 tables" "table" finishes being deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table"'s schema is evolved then maintenance configuration is applied to a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table"'s schema is evolved
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then maintenance configuration is applied to a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When maintenance configuration is applied to a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table"'s policy is deleted then compaction is started on a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table"'s policy is deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then compaction is started on a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When compaction is started on a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then compaction finishes on a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When compaction finishes on a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is created then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname not in bucket_status
    When a "s3 tables" "table" s3 tables bucket is created
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" finishes creating then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" finishes being deleted then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table"'s schema is evolved then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table"'s schema is evolved
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a policy is attached to a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a policy is attached to a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table"'s policy is deleted then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table"'s policy is deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then compaction is started on a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When compaction is started on a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes creating then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" finishes creating then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" is deleted then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" finishes being deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" finishes being deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then maintenance configuration is applied to a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a policy is attached to a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a policy is attached to a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table"'s policy is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table"'s policy is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" finishes creating then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" is deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" is deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" finishes being deleted then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" finishes being deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table"'s schema is evolved then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then maintenance configuration is applied to a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a policy is attached to a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a policy is attached to a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" s3 tables bucket finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes creating then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes creating
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is deleted then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes being deleted then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s schema is evolved then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s schema is evolved
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then maintenance configuration is applied to a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When maintenance configuration is applied to a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is created in a "s3 tables" "namespace" then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes creating then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes creating
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is deleted then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" finishes being deleted then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" finishes being deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s schema is evolved then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s schema is evolved
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" finishes creating
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" is deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" finishes being deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s schema is evolved
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then maintenance configuration is applied to a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a policy is attached to a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" finishes creating then a "s3 tables" "table"'s policy is deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" is deleted then compaction is started on a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" is deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" finishes being deleted then compaction finishes on a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket is created
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "namespace" finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given ns_key in ns_status
    When a "s3 tables" "namespace" finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table"'s schema is evolved
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then maintenance configuration is applied to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a policy is attached to a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table"'s policy is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" finishes creating then compaction is started on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" finishes creating
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" is deleted then compaction finishes on a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" is deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given bname in bucket_status
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket finishes being deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" finishes being deleted then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" finishes being deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" is created in a "s3 tables" "namespace" then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes creating then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes creating
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket is deleted then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "namespace" finishes being deleted then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket is deleted then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table" finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table" finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "snapshot" is created for a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket is created then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket is created
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket is deleted then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket is deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" s3 tables bucket finishes being deleted then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" finishes creating then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then compaction finishes on a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s schema is evolved then an expired s3 tables snapshot is removed from a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s schema is evolved
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" is deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then compaction is started on a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: maintenance configuration is applied to a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When maintenance configuration is applied to a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" is deleted then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then compaction is started on a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then compaction finishes on a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a policy is attached to a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When a policy is attached to a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket is created then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket is created
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket finishes creating then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" finishes creating then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" is deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then compaction is started on a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When compaction is started on a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then compaction finishes on a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When compaction finishes on a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: a "s3 tables" "table"'s policy is deleted then an expired s3 tables snapshot is removed from a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When a "s3 tables" "table"'s policy is deleted
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" finishes creating then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" is deleted then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a policy is attached to a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction is started on a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table" then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When compaction is started on a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" finishes creating then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" is deleted then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table" then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a policy is attached to a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then compaction is started on a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table"
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: compaction finishes on a "s3 tables" "table" then an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When compaction finishes on a "s3 tables" "table"
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created then a "s3 tables" "table" s3 tables bucket is deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    When a "s3 tables" "table" s3 tables bucket is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating then a "s3 tables" "table" s3 tables bucket finishes being deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is deleted then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is deleted
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes being deleted then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes being deleted
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket then a "s3 tables" "namespace" finishes being deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "namespace" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket then a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "namespace" finishes being deleted then a "s3 tables" "table" finishes creating
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "namespace" finishes being deleted
    When a "s3 tables" "table" finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" is created in a "s3 tables" "namespace" then a "s3 tables" "table" is deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    When a "s3 tables" "table" is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" finishes creating then a "s3 tables" "table" finishes being deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" finishes creating
    When a "s3 tables" "table" finishes being deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" is deleted then a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" is deleted
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table" finishes being deleted then a "s3 tables" "table"'s schema is evolved
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table" finishes being deleted
    When a "s3 tables" "table"'s schema is evolved
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "snapshot" is created for a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "snapshot" is created for a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table"'s schema is evolved then a policy is attached to a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table"'s schema is evolved
    When a policy is attached to a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then maintenance configuration is applied to a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When maintenance configuration is applied to a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a policy is attached to a "s3 tables" "table" then compaction is started on a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a policy is attached to a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then a "s3 tables" "table"'s policy is deleted then compaction finishes on a "s3 tables" "table"
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When a "s3 tables" "table"'s policy is deleted
    When compaction finishes on a "s3 tables" "table"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then compaction is started on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket is created
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket is created
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @sequence
  Scenario: an expired s3 tables snapshot is removed from a "s3 tables" "table" then compaction finishes on a "s3 tables" "table" then a "s3 tables" "table" s3 tables bucket finishes creating
    Given tkey in table_status
    When an expired s3 tables snapshot is removed from a "s3 tables" "table"
    When compaction finishes on a "s3 tables" "table"
    When a "s3 tables" "table" s3 tables bucket finishes creating
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one
