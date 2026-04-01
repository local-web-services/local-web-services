@s3tables @generated
Feature: S3tables - A "S3 Tables" "Table" Is Created In A "S3 Tables" "Namespace"

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "ACTIVE"
    And the "s3 tables" "namespace" existed
    And the "s3 tables" "namespace" was "ACTIVE"
    And the "s3 tables" "table" did not already exist
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Then the "s3 tables" "table" will be in "CREATING" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @create_table
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" fails when the "s3 tables" "bucket" did not exist
    Given the "s3 tables" "bucket" did not exist
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Then the operation is rejected

  @guard @negative @create_table @lifecycle
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" fails when the "s3 tables" "bucket" was not "ACTIVE"
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was not "ACTIVE"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Then the operation is rejected

  @guard @negative @create_table
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" fails when the "s3 tables" "namespace" did not exist
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "ACTIVE"
    And the "s3 tables" "namespace" did not exist
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Then the operation is rejected

  @guard @negative @create_table @lifecycle
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" fails when the "s3 tables" "namespace" was not "ACTIVE"
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "ACTIVE"
    And the "s3 tables" "namespace" existed
    And the "s3 tables" "namespace" was not "ACTIVE"
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Then the operation is rejected

  @guard @negative @create_table
  Scenario: a "s3 tables" "table" is created in a "s3 tables" "namespace" fails when the "s3 tables" "table" already existed
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "ACTIVE"
    And the "s3 tables" "namespace" existed
    And the "s3 tables" "namespace" was "ACTIVE"
    And the "s3 tables" "table" already existed
    When a "s3 tables" "table" is created in a "s3 tables" "namespace"
    Then the operation is rejected
