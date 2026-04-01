@cloudtrail @generated
Feature: Cloudtrail - A "Cloudtrail" "Event" Is Delivered To S3

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: CapacityLimitRespected, TrailCountConsistent, DeletedTrailNotLogging, EventsReferValidTrails, DeliveredEventsFromLoggingTrails

  Background:
    Given the system is initialized

  @minimal @happy @deliver_to_s3
  Scenario: a "cloudtrail" "event" is delivered to S3
    Given the "cloudtrail" "event" was "BUFFERED"
    And the associated "cloudtrail" "trail" is "LOGGING"
    When a "cloudtrail" "event" is delivered to S3
    Then the "cloudtrail" "event" will be "DELIVERED"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @guard @negative @deliver_to_s3
  Scenario: a "cloudtrail" "event" is delivered to S3 fails when not (eid in event_status)
    Given not (eid in event_status)
    When a "cloudtrail" "event" is delivered to S3
    Then the operation is rejected

  @guard @negative @deliver_to_s3
  Scenario: a "cloudtrail" "event" is delivered to S3 fails when event_status[eid] != '"BUFFERED"'
    Given the "cloudtrail" "event" was "BUFFERED"
    And event_status[eid] != '"BUFFERED"'
    When a "cloudtrail" "event" is delivered to S3
    Then the operation is rejected
