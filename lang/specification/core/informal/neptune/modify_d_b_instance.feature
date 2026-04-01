@neptune @generated
Feature: Neptune - A "Neptune" "Instance" Configuration Is Modified

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @modify_d_b_instance
  Scenario: a "neptune" "instance" configuration is modified
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "AVAILABLE"
    And the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    When a "neptune" "instance" configuration is modified
    Then the "neptune" "instance" will be in "MODIFYING" state
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @modify_d_b_instance
  Scenario: a "neptune" "instance" configuration is modified fails when the "neptune" "instance" did not exist
    Given the "neptune" "instance" did not exist
    When a "neptune" "instance" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_instance @lifecycle
  Scenario: a "neptune" "instance" configuration is modified fails when the "neptune" "instance" was not "AVAILABLE"
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was not "AVAILABLE"
    When a "neptune" "instance" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_instance
  Scenario: a "neptune" "instance" configuration is modified fails when the "neptune" "cluster" did not exist
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "AVAILABLE"
    And the "neptune" "cluster" did not exist
    When a "neptune" "instance" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_instance @lifecycle
  Scenario: a "neptune" "instance" configuration is modified fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "AVAILABLE"
    And the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When a "neptune" "instance" configuration is modified
    Then the operation is rejected
