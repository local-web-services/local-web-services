@neptune @generated
Feature: Neptune - A Database Instance Is Created In An Available Cluster

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

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
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

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

  @standard @negative @create_d_b_instance
  Scenario: a database instance is created in an available cluster fails when the instance slot is not available
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the instance slot is not available
    When a database instance is created in an available cluster
    Then the operation is rejected
