@docdb @generated
Feature: Docdb - A Database Instance Configuration Is Modified

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @modify_d_b_instance
  Scenario: a database instance configuration is modified
    Given the instance exists
    And the instance is "AVAILABLE"
    And the cluster exists
    And the cluster is "AVAILABLE"
    When a database instance configuration is modified
    Then the instance is in "MODIFYING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @standard @negative @modify_d_b_instance
  Scenario: a database instance configuration is modified fails when the instance does not exist
    Given the instance does not exist
    When a database instance configuration is modified
    Then the operation is rejected

  @standard @negative @modify_d_b_instance @lifecycle
  Scenario: a database instance configuration is modified fails when the instance is not "AVAILABLE"
    Given the instance exists
    And the instance is not "AVAILABLE"
    When a database instance configuration is modified
    Then the operation is rejected

  @standard @negative @modify_d_b_instance
  Scenario: a database instance configuration is modified fails when the cluster does not exist
    Given the instance exists
    And the instance is "AVAILABLE"
    And the cluster does not exist
    When a database instance configuration is modified
    Then the operation is rejected

  @standard @negative @modify_d_b_instance @lifecycle
  Scenario: a database instance configuration is modified fails when the cluster is not "AVAILABLE"
    Given the instance exists
    And the instance is "AVAILABLE"
    And the cluster exists
    And the cluster is not "AVAILABLE"
    When a database instance configuration is modified
    Then the operation is rejected
