@cloudtrail @generated
Feature: CloudTrail - Event Lookup

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: TrailStatusValid, LoggingOnlyForActiveTrails

  Background:
    Given the system is initialized

  @minimal @happy @lookup_events
  Scenario: lookup events returns recorded events
    Given at least one CloudTrail API call has been made
    When events are looked up
    Then the response contains recorded events
    And every trail has a valid status
