@neptune @generated
Feature: Neptune - A "Neptune" "Instance" Is Created In An Available Neptune Cluster

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: a "neptune" "instance" is created in an available neptune cluster
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And the "neptune" "instance" slot is available
    When a "neptune" "instance" is created in an available neptune cluster
    Then the "neptune" "instance" will be in "CREATING" state and associated with the "neptune" "cluster"
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @create_d_b_instance
  Scenario: a "neptune" "instance" is created in an available neptune cluster fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a "neptune" "instance" is created in an available neptune cluster
    Then the operation is rejected

  @guard @negative @create_d_b_instance @lifecycle
  Scenario: a "neptune" "instance" is created in an available neptune cluster fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When a "neptune" "instance" is created in an available neptune cluster
    Then the operation is rejected

  @guard @negative @create_d_b_instance
  Scenario: a "neptune" "instance" is created in an available neptune cluster fails when the "neptune" "instance" slot is not available
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And the "neptune" "instance" slot is not available
    When a "neptune" "instance" is created in an available neptune cluster
    Then the operation is rejected
