@cloudtrail @generated
Feature: CloudTrail - Event Selectors

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: TrailStatusValid, LoggingOnlyForActiveTrails

  Background:
    Given the system is initialized

  @minimal @happy @put_event_selectors
  Scenario: event selectors are stored for a trail
    Given the trail exists and is active
    When event selectors are put for the trail
    Then the event selectors are returned for the trail
    And every trail has a valid status

  @standard @negative @put_event_selectors
  Scenario: put event selectors fails when the trail does not exist
    Given the trail does not exist
    When event selectors are put for the trail
    Then the operation is rejected
