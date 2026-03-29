@docdb @generated
Feature: Docdb - A Database Instance Is Created In An Available Cluster

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: a database instance is created in an available cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the instance slot is available
    When a database instance is created in an available cluster
    Then the instance is in "CREATING" state and associated with the cluster
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @standard @negative @create_d_b_instance
  Scenario: a database instance is created in an available cluster fails when the cluster does not exist
    Given the cluster does not exist
    When a database instance is created in an available cluster
    Then the operation is rejected

  @standard @negative @create_d_b_instance @lifecycle
  Scenario: a database instance is created in an available cluster fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a database instance is created in an available cluster
    Then the operation is rejected

  @standard @negative @internal @create_d_b_instance
  Scenario: a database instance is created in an available cluster fails when the instance slot is not available
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the instance slot is not available
    When a database instance is created in an available cluster
    Then the operation is rejected
