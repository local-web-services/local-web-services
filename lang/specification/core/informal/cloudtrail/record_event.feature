@cloudtrail @generated
Feature: Cloudtrail - A "Cloudtrail" "Event" Is Recorded

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: CapacityLimitRespected, TrailCountConsistent, DeletedTrailNotLogging, EventsReferValidTrails, DeliveredEventsFromLoggingTrails

  Background:
    Given the system is initialized

  @minimal @happy @record_event
  Scenario: a "cloudtrail" "event" is recorded
    Given at least one "cloudtrail" "trail" is logging
    When a "cloudtrail" "event" is recorded
    Then the "cloudtrail" "event" will be "BUFFERED"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @guard @negative @record_event
  Scenario: a "cloudtrail" "event" is recorded fails when not (eid not in event_status)
    Given not (eid not in event_status)
    When a "cloudtrail" "event" is recorded
    Then the operation is rejected
