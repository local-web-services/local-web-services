@rds @generated
Feature: Rds - Action Sequences

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @sequence
  Scenario: a database instance is created then a database instance finishes creating
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance configuration is modified
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance modification completes
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance is rebooted
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance reboot completes
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance is deleted without a final snapshot
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance is deleted with a final snapshot
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance deletion completes
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database snapshot is created from an instance
    Given iid not in instance_status
    Given a database instance has been created
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database snapshot finishes creating
    Given iid not in instance_status
    Given a database instance has been created
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database snapshot is deleted
    Given iid not in instance_status
    Given a database instance has been created
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database snapshot deletion completes
    Given iid not in instance_status
    Given a database instance has been created
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance is restored from a snapshot
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance restore from snapshot completes
    Given iid not in instance_status
    Given a database instance has been created
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then an automated backup runs on an available instance
    Given iid not in instance_status
    Given a database instance has been created
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a multi-"AZ" failover is triggered on an instance
    Given iid not in instance_status
    Given a database instance has been created
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then multi-"AZ" is enabled on a database instance
    Given iid not in instance_status
    Given a database instance has been created
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a tag is applied to a database instance
    Given iid not in instance_status
    Given a database instance has been created
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is created
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance modification completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is rebooted
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance reboot completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance has finished creating
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance has finished creating
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance has finished creating
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance has finished creating
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance has finished creating
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance has finished creating
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance has finished creating
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is created
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance modification completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is rebooted
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance reboot completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is created
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is rebooted
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance reboot completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance modification has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance modification has completed
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance modification has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance modification has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance modification has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance modification has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance is created
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance finishes creating
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance modification completes
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance reboot completes
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance has been rebooted
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance has been rebooted
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance has been rebooted
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance has been rebooted
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance has been rebooted
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is created
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance modification completes
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is rebooted
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance deletion completes
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance reboot has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance reboot has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance reboot has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance reboot has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance reboot has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance is created
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance finishes creating
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance modification completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance is rebooted
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance reboot completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance is created
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance finishes creating
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance modification completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance is rebooted
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance reboot completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is created
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance modification completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is rebooted
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance reboot completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance deletion has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance deletion has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance deletion has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance deletion has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is created
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance finishes creating
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance configuration is modified
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance modification completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is rebooted
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance reboot completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance deletion completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database snapshot finishes creating
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database snapshot is deleted
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database snapshot deletion completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a tag is applied to a database instance
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is created
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance finishes creating
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance modification completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is rebooted
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance reboot completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is deleted without a final snapshot
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is deleted with a final snapshot
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance deletion completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database snapshot is created from an instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database snapshot is deleted
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database snapshot deletion completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is restored from a snapshot
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance restore from snapshot completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then an automated backup runs on an available instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a multi-"AZ" failover is triggered on an instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then multi-"AZ" is enabled on a database instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a tag is applied to a database instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is created
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance finishes creating
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance modification completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is rebooted
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance reboot completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is deleted without a final snapshot
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is deleted with a final snapshot
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance deletion completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database snapshot is created from an instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database snapshot finishes creating
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database snapshot deletion completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is restored from a snapshot
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance restore from snapshot completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then an automated backup runs on an available instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a multi-"AZ" failover is triggered on an instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then multi-"AZ" is enabled on a database instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a tag is applied to a database instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is created
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance finishes creating
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance modification completes
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is rebooted
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance reboot completes
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is deleted without a final snapshot
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is deleted with a final snapshot
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance deletion completes
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database snapshot is created from an instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database snapshot finishes creating
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database snapshot is deleted
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is restored from a snapshot
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance restore from snapshot completes
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then an automated backup runs on an available instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a multi-"AZ" failover is triggered on an instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then multi-"AZ" is enabled on a database instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a tag is applied to a database instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance is created
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance finishes creating
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance modification completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance is rebooted
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance reboot completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance is deleted without a final snapshot
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance is deleted with a final snapshot
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance deletion completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database snapshot is created from an instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database snapshot finishes creating
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database snapshot is deleted
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database snapshot deletion completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance restore from snapshot completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then an automated backup runs on an available instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a multi-"AZ" failover is triggered on an instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then multi-"AZ" is enabled on a database instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a tag is applied to a database instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is created
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance modification completes
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is rebooted
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance reboot completes
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance deletion completes
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is created
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance finishes creating
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance configuration is modified
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance modification completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is rebooted
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance reboot completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance deletion completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database snapshot is created from an instance
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database snapshot finishes creating
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database snapshot is deleted
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database snapshot deletion completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is restored from a snapshot
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance restore from snapshot completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a tag is applied to a database instance
    Given iid in instance_status
    Given an automated backup has run on an available instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is created
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance finishes creating
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance configuration is modified
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance modification completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is rebooted
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance reboot completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance deletion completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database snapshot is created from an instance
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database snapshot finishes creating
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database snapshot is deleted
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database snapshot deletion completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then an automated backup runs on an available instance
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a tag is applied to a database instance
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is created
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance finishes creating
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance configuration is modified
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance modification completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is rebooted
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance reboot completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance deletion completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database snapshot is created from an instance
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database snapshot finishes creating
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database snapshot is deleted
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database snapshot deletion completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is restored from a snapshot
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance restore from snapshot completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then an automated backup runs on an available instance
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a tag is applied to a database instance
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is created
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance finishes creating
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance configuration is modified
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance modification completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is rebooted
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance reboot completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance deletion completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database snapshot is created from an instance
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database snapshot finishes creating
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database snapshot is deleted
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database snapshot deletion completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then an automated backup runs on an available instance
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a tag has been applied to a database instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance finishes creating then a database instance configuration is modified
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance has finished creating
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance configuration is modified then a database instance modification completes
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance configuration has been modified
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance modification completes then a database instance is rebooted
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance modification has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance is rebooted then a database instance reboot completes
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance has been rebooted
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance reboot completes then a database instance is deleted without a final snapshot
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance reboot has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance is deleted without a final snapshot then a database instance is deleted with a final snapshot
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance has been deleted without a final snapshot
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance is deleted with a final snapshot then a database instance deletion completes
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance has been deleted with a final snapshot
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance deletion completes then a database snapshot is created from an instance
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance deletion has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database snapshot is created from an instance then a database snapshot finishes creating
    Given iid not in instance_status
    Given a database instance has been created
    Given a database snapshot has been created from an instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database snapshot finishes creating then a database snapshot is deleted
    Given iid not in instance_status
    Given a database instance has been created
    Given a database snapshot has finished creating
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database snapshot is deleted then a database snapshot deletion completes
    Given iid not in instance_status
    Given a database instance has been created
    Given a database snapshot has been deleted
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database snapshot deletion completes then a database instance is restored from a snapshot
    Given iid not in instance_status
    Given a database instance has been created
    Given a database snapshot deletion has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance is restored from a snapshot then a database instance restore from snapshot completes
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance has been restored from a snapshot
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a database instance restore from snapshot completes then an automated backup runs on an available instance
    Given iid not in instance_status
    Given a database instance has been created
    Given a database instance restore from snapshot has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then an automated backup runs on an available instance then a multi-"AZ" failover is triggered on an instance
    Given iid not in instance_status
    Given a database instance has been created
    Given an automated backup has run on an available instance
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a multi-"AZ" failover is triggered on an instance then multi-"AZ" is enabled on a database instance
    Given iid not in instance_status
    Given a database instance has been created
    Given a multi-"AZ" failover has been triggered on an instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then multi-"AZ" is enabled on a database instance then a tag is applied to a database instance
    Given iid not in instance_status
    Given a database instance has been created
    Given multi-"AZ" has been enabled on a database instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is created then a tag is applied to a database instance then a database instance finishes creating
    Given iid not in instance_status
    Given a database instance has been created
    Given a tag has been applied to a database instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is created then a database instance modification completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance has been created
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance configuration is modified then a database instance is rebooted
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance configuration has been modified
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance modification completes then a database instance reboot completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance modification has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is rebooted then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance has been rebooted
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance reboot completes then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance reboot has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is deleted without a final snapshot then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance has been deleted without a final snapshot
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is deleted with a final snapshot then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance has been deleted with a final snapshot
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance deletion completes then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance deletion has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database snapshot is created from an instance then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database snapshot has been created from an instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database snapshot finishes creating then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database snapshot has finished creating
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database snapshot is deleted then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database snapshot has been deleted
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database snapshot deletion completes then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database snapshot deletion has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance is restored from a snapshot then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance has been restored from a snapshot
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a database instance restore from snapshot completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance restore from snapshot has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then an automated backup runs on an available instance then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance has finished creating
    Given an automated backup has run on an available instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a multi-"AZ" failover is triggered on an instance then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance has finished creating
    Given a multi-"AZ" failover has been triggered on an instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then multi-"AZ" is enabled on a database instance then a database instance is created
    Given iid in instance_status
    Given a database instance has finished creating
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance finishes creating then a tag is applied to a database instance then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has finished creating
    Given a tag has been applied to a database instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is created then a database instance is rebooted
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has been created
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance finishes creating then a database instance reboot completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has finished creating
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance modification completes then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance modification has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is rebooted then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has been rebooted
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance reboot completes then a database instance deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance reboot has completed
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is deleted without a final snapshot then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has been deleted without a final snapshot
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is deleted with a final snapshot then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has been deleted with a final snapshot
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance deletion completes then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance deletion has completed
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database snapshot is created from an instance then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database snapshot has been created from an instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database snapshot finishes creating then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database snapshot has finished creating
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database snapshot is deleted then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database snapshot has been deleted
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database snapshot deletion completes then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database snapshot deletion has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance is restored from a snapshot then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has been restored from a snapshot
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a database instance restore from snapshot completes then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance restore from snapshot has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then an automated backup runs on an available instance then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given an automated backup has run on an available instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a multi-"AZ" failover is triggered on an instance then a database instance is created
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then multi-"AZ" is enabled on a database instance then a database instance finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given multi-"AZ" has been enabled on a database instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance configuration is modified then a tag is applied to a database instance then a database instance modification completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a tag has been applied to a database instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is created then a database instance reboot completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has been created
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance finishes creating then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has finished creating
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance configuration is modified then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance configuration has been modified
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is rebooted then a database instance deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has been rebooted
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance reboot completes then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance reboot has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is deleted without a final snapshot then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has been deleted without a final snapshot
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is deleted with a final snapshot then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has been deleted with a final snapshot
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance deletion completes then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance deletion has completed
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database snapshot is created from an instance then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database snapshot has been created from an instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database snapshot finishes creating then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database snapshot has finished creating
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database snapshot is deleted then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database snapshot has been deleted
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database snapshot deletion completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database snapshot deletion has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance is restored from a snapshot then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has been restored from a snapshot
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a database instance restore from snapshot completes then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance restore from snapshot has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then an automated backup runs on an available instance then a database instance is created
    Given iid in instance_status
    Given a database instance modification has completed
    Given an automated backup has run on an available instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a multi-"AZ" failover is triggered on an instance then a database instance finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then multi-"AZ" is enabled on a database instance then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance modification has completed
    Given multi-"AZ" has been enabled on a database instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance modification completes then a tag is applied to a database instance then a database instance is rebooted
    Given iid in instance_status
    Given a database instance modification has completed
    Given a tag has been applied to a database instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance is created then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance has been created
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance finishes creating then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance has finished creating
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance configuration is modified then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance configuration has been modified
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance modification completes then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance modification has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance reboot completes then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance reboot has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance is deleted without a final snapshot then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance has been deleted without a final snapshot
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance is deleted with a final snapshot then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance has been deleted with a final snapshot
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance deletion completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance deletion has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database snapshot is created from an instance then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database snapshot has been created from an instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database snapshot finishes creating then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database snapshot has finished creating
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database snapshot is deleted then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database snapshot has been deleted
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database snapshot deletion completes then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database snapshot deletion has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance is restored from a snapshot then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance has been restored from a snapshot
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a database instance restore from snapshot completes then a database instance is created
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a database instance restore from snapshot has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then an automated backup runs on an available instance then a database instance finishes creating
    Given iid in instance_status
    Given a database instance has been rebooted
    Given an automated backup has run on an available instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a multi-"AZ" failover is triggered on an instance then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then multi-"AZ" is enabled on a database instance then a database instance modification completes
    Given iid in instance_status
    Given a database instance has been rebooted
    Given multi-"AZ" has been enabled on a database instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is rebooted then a tag is applied to a database instance then a database instance reboot completes
    Given iid in instance_status
    Given a database instance has been rebooted
    Given a tag has been applied to a database instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is created then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance has been created
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance finishes creating then a database instance deletion completes
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance has finished creating
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance configuration is modified then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance configuration has been modified
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance modification completes then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance modification has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is rebooted then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance has been rebooted
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is deleted without a final snapshot then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance has been deleted without a final snapshot
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is deleted with a final snapshot then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance has been deleted with a final snapshot
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance deletion completes then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance deletion has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database snapshot is created from an instance then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database snapshot has been created from an instance
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database snapshot finishes creating then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database snapshot has finished creating
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database snapshot is deleted then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database snapshot has been deleted
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database snapshot deletion completes then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database snapshot deletion has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance is restored from a snapshot then a database instance is created
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance has been restored from a snapshot
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a database instance restore from snapshot completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a database instance restore from snapshot has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then an automated backup runs on an available instance then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance reboot has completed
    Given an automated backup has run on an available instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a multi-"AZ" failover is triggered on an instance then a database instance modification completes
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then multi-"AZ" is enabled on a database instance then a database instance is rebooted
    Given iid in instance_status
    Given a database instance reboot has completed
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance reboot completes then a tag is applied to a database instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance reboot has completed
    Given a tag has been applied to a database instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance is created then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance has been created
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance finishes creating then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance has finished creating
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance configuration is modified then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance configuration has been modified
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance modification completes then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance modification has completed
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance is rebooted then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance has been rebooted
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance reboot completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance reboot has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance is deleted with a final snapshot then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance has been deleted with a final snapshot
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance deletion completes then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance deletion has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database snapshot is created from an instance then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database snapshot has been created from an instance
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database snapshot finishes creating then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database snapshot has finished creating
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database snapshot is deleted then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database snapshot has been deleted
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database snapshot deletion completes then a database instance is created
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database snapshot deletion has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance is restored from a snapshot then a database instance finishes creating
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance has been restored from a snapshot
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a database instance restore from snapshot completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a database instance restore from snapshot has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then an automated backup runs on an available instance then a database instance modification completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given an automated backup has run on an available instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a multi-"AZ" failover is triggered on an instance then a database instance is rebooted
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then multi-"AZ" is enabled on a database instance then a database instance reboot completes
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given multi-"AZ" has been enabled on a database instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted without a final snapshot then a tag is applied to a database instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance has been deleted without a final snapshot
    Given a tag has been applied to a database instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance is created then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance has been created
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance finishes creating then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance has finished creating
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance configuration is modified then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance configuration has been modified
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance modification completes then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance modification has completed
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance is rebooted then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance has been rebooted
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance reboot completes then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance reboot has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance is deleted without a final snapshot then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance has been deleted without a final snapshot
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance deletion completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance deletion has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database snapshot is created from an instance then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database snapshot has been created from an instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database snapshot finishes creating then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database snapshot has finished creating
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database snapshot is deleted then a database instance is created
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database snapshot has been deleted
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database snapshot deletion completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database snapshot deletion has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance is restored from a snapshot then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance has been restored from a snapshot
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a database instance restore from snapshot completes then a database instance modification completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a database instance restore from snapshot has completed
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then an automated backup runs on an available instance then a database instance is rebooted
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given an automated backup has run on an available instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a multi-"AZ" failover is triggered on an instance then a database instance reboot completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then multi-"AZ" is enabled on a database instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is deleted with a final snapshot then a tag is applied to a database instance then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has been deleted with a final snapshot
    Given a tag has been applied to a database instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is created then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has been created
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance finishes creating then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has finished creating
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance configuration is modified then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance configuration has been modified
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance modification completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance modification has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is rebooted then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has been rebooted
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance reboot completes then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance reboot has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is deleted without a final snapshot then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has been deleted without a final snapshot
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is deleted with a final snapshot then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has been deleted with a final snapshot
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database snapshot is created from an instance then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database snapshot has been created from an instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database snapshot finishes creating then a database instance is created
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database snapshot has finished creating
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database snapshot is deleted then a database instance finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database snapshot has been deleted
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database snapshot deletion completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database snapshot deletion has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance is restored from a snapshot then a database instance modification completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has been restored from a snapshot
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a database instance restore from snapshot completes then a database instance is rebooted
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance restore from snapshot has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then an automated backup runs on an available instance then a database instance reboot completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given an automated backup has run on an available instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a multi-"AZ" failover is triggered on an instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then multi-"AZ" is enabled on a database instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance deletion has completed
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance deletion completes then a tag is applied to a database instance then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a tag has been applied to a database instance
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is created then a database snapshot is deleted
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance has been created
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance finishes creating then a database snapshot deletion completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance has finished creating
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance configuration is modified then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance configuration has been modified
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance modification completes then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance modification has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is rebooted then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance has been rebooted
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance reboot completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance reboot has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is deleted without a final snapshot then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance has been deleted without a final snapshot
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is deleted with a final snapshot then a tag is applied to a database instance
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance has been deleted with a final snapshot
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance deletion completes then a database instance is created
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance deletion has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database snapshot finishes creating then a database instance finishes creating
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database snapshot has finished creating
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database snapshot is deleted then a database instance configuration is modified
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database snapshot has been deleted
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database snapshot deletion completes then a database instance modification completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database snapshot deletion has completed
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance is restored from a snapshot then a database instance is rebooted
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance has been restored from a snapshot
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a database instance restore from snapshot completes then a database instance reboot completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a database instance restore from snapshot has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then an automated backup runs on an available instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given an automated backup has run on an available instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a multi-"AZ" failover is triggered on an instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then multi-"AZ" is enabled on a database instance then a database instance deletion completes
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given multi-"AZ" has been enabled on a database instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is created from an instance then a tag is applied to a database instance then a database snapshot finishes creating
    Given iid in instance_status
    Given a database snapshot has been created from an instance
    Given a tag has been applied to a database instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is created then a database snapshot deletion completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance has been created
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance finishes creating then a database instance is restored from a snapshot
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance has finished creating
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance configuration is modified then a database instance restore from snapshot completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance configuration has been modified
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance modification completes then an automated backup runs on an available instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance modification has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is rebooted then a multi-"AZ" failover is triggered on an instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance has been rebooted
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance reboot completes then multi-"AZ" is enabled on a database instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance reboot has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is deleted without a final snapshot then a tag is applied to a database instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance has been deleted without a final snapshot
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is deleted with a final snapshot then a database instance is created
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance has been deleted with a final snapshot
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance deletion completes then a database instance finishes creating
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance deletion has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database snapshot is created from an instance then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database snapshot has been created from an instance
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database snapshot is deleted then a database instance modification completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database snapshot has been deleted
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database snapshot deletion completes then a database instance is rebooted
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database snapshot deletion has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance is restored from a snapshot then a database instance reboot completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance has been restored from a snapshot
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a database instance restore from snapshot completes then a database instance is deleted without a final snapshot
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a database instance restore from snapshot has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then an automated backup runs on an available instance then a database instance is deleted with a final snapshot
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given an automated backup has run on an available instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a multi-"AZ" failover is triggered on an instance then a database instance deletion completes
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then multi-"AZ" is enabled on a database instance then a database snapshot is created from an instance
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given multi-"AZ" has been enabled on a database instance
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot finishes creating then a tag is applied to a database instance then a database snapshot is deleted
    Given sid in snapshot_status
    Given a database snapshot has finished creating
    Given a tag has been applied to a database instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is created then a database instance is restored from a snapshot
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance has been created
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance finishes creating then a database instance restore from snapshot completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance has finished creating
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance configuration is modified then an automated backup runs on an available instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance configuration has been modified
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance modification completes then a multi-"AZ" failover is triggered on an instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance modification has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is rebooted then multi-"AZ" is enabled on a database instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance has been rebooted
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance reboot completes then a tag is applied to a database instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance reboot has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is deleted without a final snapshot then a database instance is created
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance has been deleted without a final snapshot
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is deleted with a final snapshot then a database instance finishes creating
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance has been deleted with a final snapshot
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance deletion completes then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance deletion has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database snapshot is created from an instance then a database instance modification completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database snapshot has been created from an instance
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database snapshot finishes creating then a database instance is rebooted
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database snapshot has finished creating
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database snapshot deletion completes then a database instance reboot completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database snapshot deletion has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance is restored from a snapshot then a database instance is deleted without a final snapshot
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance has been restored from a snapshot
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a database instance restore from snapshot completes then a database instance is deleted with a final snapshot
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a database instance restore from snapshot has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then an automated backup runs on an available instance then a database instance deletion completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given an automated backup has run on an available instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a multi-"AZ" failover is triggered on an instance then a database snapshot is created from an instance
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a multi-"AZ" failover has been triggered on an instance
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then multi-"AZ" is enabled on a database instance then a database snapshot finishes creating
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given multi-"AZ" has been enabled on a database instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot is deleted then a tag is applied to a database instance then a database snapshot deletion completes
    Given sid in snapshot_status
    Given a database snapshot has been deleted
    Given a tag has been applied to a database instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is created then a database instance restore from snapshot completes
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance has been created
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance finishes creating then an automated backup runs on an available instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance has finished creating
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance configuration is modified then a multi-"AZ" failover is triggered on an instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance configuration has been modified
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance modification completes then multi-"AZ" is enabled on a database instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance modification has completed
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is rebooted then a tag is applied to a database instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance has been rebooted
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance reboot completes then a database instance is created
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance reboot has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is deleted without a final snapshot then a database instance finishes creating
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance has been deleted without a final snapshot
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is deleted with a final snapshot then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance has been deleted with a final snapshot
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance deletion completes then a database instance modification completes
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance deletion has completed
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database snapshot is created from an instance then a database instance is rebooted
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database snapshot has been created from an instance
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database snapshot finishes creating then a database instance reboot completes
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database snapshot has finished creating
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database snapshot is deleted then a database instance is deleted without a final snapshot
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database snapshot has been deleted
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance is restored from a snapshot then a database instance is deleted with a final snapshot
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance has been restored from a snapshot
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a database instance restore from snapshot completes then a database instance deletion completes
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a database instance restore from snapshot has completed
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then an automated backup runs on an available instance then a database snapshot is created from an instance
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given an automated backup has run on an available instance
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a multi-"AZ" failover is triggered on an instance then a database snapshot finishes creating
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a multi-"AZ" failover has been triggered on an instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then multi-"AZ" is enabled on a database instance then a database snapshot is deleted
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given multi-"AZ" has been enabled on a database instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database snapshot deletion completes then a tag is applied to a database instance then a database instance is restored from a snapshot
    Given sid in snapshot_status
    Given a database snapshot deletion has completed
    Given a tag has been applied to a database instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance is created then an automated backup runs on an available instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance has been created
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance finishes creating then a multi-"AZ" failover is triggered on an instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance has finished creating
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance configuration is modified then multi-"AZ" is enabled on a database instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance configuration has been modified
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance modification completes then a tag is applied to a database instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance modification has completed
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance is rebooted then a database instance is created
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance has been rebooted
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance reboot completes then a database instance finishes creating
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance reboot has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance is deleted without a final snapshot then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance has been deleted without a final snapshot
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance is deleted with a final snapshot then a database instance modification completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance has been deleted with a final snapshot
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance deletion completes then a database instance is rebooted
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance deletion has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database snapshot is created from an instance then a database instance reboot completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database snapshot has been created from an instance
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database snapshot finishes creating then a database instance is deleted without a final snapshot
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database snapshot has finished creating
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database snapshot is deleted then a database instance is deleted with a final snapshot
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database snapshot has been deleted
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database snapshot deletion completes then a database instance deletion completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database snapshot deletion has completed
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a database instance restore from snapshot completes then a database snapshot is created from an instance
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a database instance restore from snapshot has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then an automated backup runs on an available instance then a database snapshot finishes creating
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given an automated backup has run on an available instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a multi-"AZ" failover is triggered on an instance then a database snapshot is deleted
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a multi-"AZ" failover has been triggered on an instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then multi-"AZ" is enabled on a database instance then a database snapshot deletion completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given multi-"AZ" has been enabled on a database instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance is restored from a snapshot then a tag is applied to a database instance then a database instance restore from snapshot completes
    Given sid in snapshot_status
    Given a database instance has been restored from a snapshot
    Given a tag has been applied to a database instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is created then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance has been created
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance finishes creating then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance has finished creating
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance configuration is modified then a tag is applied to a database instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance configuration has been modified
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance modification completes then a database instance is created
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance modification has completed
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is rebooted then a database instance finishes creating
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance has been rebooted
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance reboot completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance reboot has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is deleted without a final snapshot then a database instance modification completes
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance has been deleted without a final snapshot
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is deleted with a final snapshot then a database instance is rebooted
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance has been deleted with a final snapshot
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance deletion completes then a database instance reboot completes
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance deletion has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database snapshot is created from an instance then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database snapshot has been created from an instance
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database snapshot finishes creating then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database snapshot has finished creating
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database snapshot is deleted then a database instance deletion completes
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database snapshot has been deleted
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database snapshot deletion completes then a database snapshot is created from an instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database snapshot deletion has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a database instance is restored from a snapshot then a database snapshot finishes creating
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a database instance has been restored from a snapshot
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then an automated backup runs on an available instance then a database snapshot is deleted
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given an automated backup has run on an available instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a multi-"AZ" failover is triggered on an instance then a database snapshot deletion completes
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a multi-"AZ" failover has been triggered on an instance
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then multi-"AZ" is enabled on a database instance then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given multi-"AZ" has been enabled on a database instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a database instance restore from snapshot completes then a tag is applied to a database instance then an automated backup runs on an available instance
    Given iid in instance_status
    Given a database instance restore from snapshot has completed
    Given a tag has been applied to a database instance
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is created then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance has been created
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance finishes creating then a tag is applied to a database instance
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance has finished creating
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance configuration is modified then a database instance is created
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance configuration has been modified
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance modification completes then a database instance finishes creating
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance modification has completed
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is rebooted then a database instance configuration is modified
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance has been rebooted
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance reboot completes then a database instance modification completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance reboot has completed
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is deleted without a final snapshot then a database instance is rebooted
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance has been deleted without a final snapshot
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is deleted with a final snapshot then a database instance reboot completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance has been deleted with a final snapshot
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance deletion completes then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance deletion has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database snapshot is created from an instance then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database snapshot has been created from an instance
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database snapshot finishes creating then a database instance deletion completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database snapshot has finished creating
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database snapshot is deleted then a database snapshot is created from an instance
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database snapshot has been deleted
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database snapshot deletion completes then a database snapshot finishes creating
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database snapshot deletion has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance is restored from a snapshot then a database snapshot is deleted
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance has been restored from a snapshot
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a database instance restore from snapshot completes then a database snapshot deletion completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a database instance restore from snapshot has completed
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a multi-"AZ" failover is triggered on an instance then a database instance is restored from a snapshot
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then multi-"AZ" is enabled on a database instance then a database instance restore from snapshot completes
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given multi-"AZ" has been enabled on a database instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: an automated backup runs on an available instance then a tag is applied to a database instance then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given an automated backup has run on an available instance
    Given a tag has been applied to a database instance
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is created then a tag is applied to a database instance
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance has been created
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance finishes creating then a database instance is created
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance has finished creating
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance configuration is modified then a database instance finishes creating
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance configuration has been modified
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance modification completes then a database instance configuration is modified
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance modification has completed
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is rebooted then a database instance modification completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance has been rebooted
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance reboot completes then a database instance is rebooted
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance reboot has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is deleted without a final snapshot then a database instance reboot completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance has been deleted without a final snapshot
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is deleted with a final snapshot then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance has been deleted with a final snapshot
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance deletion completes then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance deletion has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database snapshot is created from an instance then a database instance deletion completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database snapshot has been created from an instance
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database snapshot finishes creating then a database snapshot is created from an instance
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database snapshot has finished creating
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database snapshot is deleted then a database snapshot finishes creating
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database snapshot has been deleted
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database snapshot deletion completes then a database snapshot is deleted
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database snapshot deletion has completed
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance is restored from a snapshot then a database snapshot deletion completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance has been restored from a snapshot
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a database instance restore from snapshot completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a database instance restore from snapshot has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then an automated backup runs on an available instance then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given an automated backup has run on an available instance
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then multi-"AZ" is enabled on a database instance then an automated backup runs on an available instance
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given multi-"AZ" has been enabled on a database instance
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a multi-"AZ" failover is triggered on an instance then a tag is applied to a database instance then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a multi-"AZ" failover has been triggered on an instance
    Given a tag has been applied to a database instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is created then a database instance finishes creating
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance has been created
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance finishes creating then a database instance configuration is modified
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance has finished creating
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance configuration is modified then a database instance modification completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance configuration has been modified
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance modification completes then a database instance is rebooted
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance modification has completed
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is rebooted then a database instance reboot completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance has been rebooted
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance reboot completes then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance reboot has completed
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is deleted without a final snapshot then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance has been deleted without a final snapshot
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is deleted with a final snapshot then a database instance deletion completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance has been deleted with a final snapshot
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance deletion completes then a database snapshot is created from an instance
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance deletion has completed
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database snapshot is created from an instance then a database snapshot finishes creating
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database snapshot has been created from an instance
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database snapshot finishes creating then a database snapshot is deleted
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database snapshot has finished creating
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database snapshot is deleted then a database snapshot deletion completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database snapshot has been deleted
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database snapshot deletion completes then a database instance is restored from a snapshot
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database snapshot deletion has completed
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance is restored from a snapshot then a database instance restore from snapshot completes
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance has been restored from a snapshot
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a database instance restore from snapshot completes then an automated backup runs on an available instance
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a database instance restore from snapshot has completed
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then an automated backup runs on an available instance then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given an automated backup has run on an available instance
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a multi-"AZ" failover is triggered on an instance then a tag is applied to a database instance
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a multi-"AZ" failover has been triggered on an instance
    When a tag is applied to a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: multi-"AZ" is enabled on a database instance then a tag is applied to a database instance then a database instance is created
    Given iid in instance_status
    Given multi-"AZ" has been enabled on a database instance
    Given a tag has been applied to a database instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is created then a database instance configuration is modified
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance has been created
    When a database instance configuration is modified
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance finishes creating then a database instance modification completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance has finished creating
    When a database instance modification completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance configuration is modified then a database instance is rebooted
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance configuration has been modified
    When a database instance is rebooted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance modification completes then a database instance reboot completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance modification has completed
    When a database instance reboot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is rebooted then a database instance is deleted without a final snapshot
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance has been rebooted
    When a database instance is deleted without a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance reboot completes then a database instance is deleted with a final snapshot
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance reboot has completed
    When a database instance is deleted with a final snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is deleted without a final snapshot then a database instance deletion completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance has been deleted without a final snapshot
    When a database instance deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is deleted with a final snapshot then a database snapshot is created from an instance
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance has been deleted with a final snapshot
    When a database snapshot is created from an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance deletion completes then a database snapshot finishes creating
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance deletion has completed
    When a database snapshot finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database snapshot is created from an instance then a database snapshot is deleted
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database snapshot has been created from an instance
    When a database snapshot is deleted
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database snapshot finishes creating then a database snapshot deletion completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database snapshot has finished creating
    When a database snapshot deletion completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database snapshot is deleted then a database instance is restored from a snapshot
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database snapshot has been deleted
    When a database instance is restored from a snapshot
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database snapshot deletion completes then a database instance restore from snapshot completes
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database snapshot deletion has completed
    When a database instance restore from snapshot completes
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance is restored from a snapshot then an automated backup runs on an available instance
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance has been restored from a snapshot
    When an automated backup runs on an available instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a database instance restore from snapshot completes then a multi-"AZ" failover is triggered on an instance
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a database instance restore from snapshot has completed
    When a multi-"AZ" failover is triggered on an instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then an automated backup runs on an available instance then multi-"AZ" is enabled on a database instance
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given an automated backup has run on an available instance
    When multi-"AZ" is enabled on a database instance
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then a multi-"AZ" failover is triggered on an instance then a database instance is created
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given a multi-"AZ" failover has been triggered on an instance
    When a database instance is created
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @sequence
  Scenario: a tag is applied to a database instance then multi-"AZ" is enabled on a database instance then a database instance finishes creating
    Given iid in instance_status
    Given a tag has been applied to a database instance
    Given multi-"AZ" has been enabled on a database instance
    When a database instance finishes creating
    Then every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot
