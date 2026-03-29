@cloudtrail @generated
Feature: CloudTrail - A Trail Is Created

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: TrailStatusValid, LoggingOnlyForActiveTrails

  Background:
    Given the system is initialized

  @minimal @happy @create_trail
  Scenario: a trail is created
    Given the trail does not already exist
    When a trail is created
    Then the trail exists and is active
    And every trail has a valid status

  @standard @negative @create_trail
  Scenario: a trail is created fails when the trail already exists
    Given the trail already exists
    When a trail is created
    Then the operation is rejected
