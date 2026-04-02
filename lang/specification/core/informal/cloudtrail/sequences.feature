@cloudtrail @generated
Feature: Cloudtrail - Action Sequences

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: CapacityLimitRespected, TrailCountConsistent, DeletedTrailNotLogging, EventsReferValidTrails, DeliveredEventsFromLoggingTrails

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "cloudtrail" "trail" is created then "StartLogging" is called on a "cloudtrail" "trail"
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then "StopLogging" is called on a "cloudtrail" "trail"
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then a "cloudtrail" "trail" is deleted
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then a "cloudtrail" "event" is recorded
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then a "cloudtrail" "event" is delivered to S3
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is created
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then "StopLogging" is called on a "cloudtrail" "trail"
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is deleted
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is recorded
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is delivered to S3
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is created
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then "StartLogging" is called on a "cloudtrail" "trail"
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is deleted
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is recorded
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is delivered to S3
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then a "cloudtrail" "trail" is created
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then "StartLogging" is called on a "cloudtrail" "trail"
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then "StopLogging" is called on a "cloudtrail" "trail"
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then a "cloudtrail" "event" is recorded
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then a "cloudtrail" "event" is delivered to S3
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then a "cloudtrail" "trail" is created
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then "StartLogging" is called on a "cloudtrail" "trail"
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then "StopLogging" is called on a "cloudtrail" "trail"
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then a "cloudtrail" "trail" is deleted
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then a "cloudtrail" "event" is delivered to S3
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "trail" is created
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then "StartLogging" is called on a "cloudtrail" "trail"
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then "StopLogging" is called on a "cloudtrail" "trail"
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "trail" is deleted
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "event" is recorded
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then "StartLogging" is called on a "cloudtrail" "trail" then "StopLogging" is called on a "cloudtrail" "trail"
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When "StartLogging" is called on a "cloudtrail" "trail"
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is deleted
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then a "cloudtrail" "trail" is deleted then a "cloudtrail" "event" is recorded
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then a "cloudtrail" "event" is recorded then a "cloudtrail" "event" is delivered to S3
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "event" is recorded
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is created then a "cloudtrail" "event" is delivered to S3 then "StartLogging" is called on a "cloudtrail" "trail"
    Given tname not in trail_status
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "event" is delivered to S3
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is created then a "cloudtrail" "trail" is deleted
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is recorded
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is deleted then a "cloudtrail" "event" is delivered to S3
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is recorded then a "cloudtrail" "trail" is created
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is recorded
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is delivered to S3 then "StopLogging" is called on a "cloudtrail" "trail"
    Given tname in trail_status
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is delivered to S3
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is created then a "cloudtrail" "event" is recorded
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is delivered to S3
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is deleted then a "cloudtrail" "trail" is created
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is recorded then "StartLogging" is called on a "cloudtrail" "trail"
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is recorded
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "trail" is deleted
    Given tname in trail_status
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then a "cloudtrail" "trail" is created then a "cloudtrail" "event" is delivered to S3
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "trail" is created
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is created
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then "StopLogging" is called on a "cloudtrail" "trail" then "StartLogging" is called on a "cloudtrail" "trail"
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When "StopLogging" is called on a "cloudtrail" "trail"
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then a "cloudtrail" "event" is recorded then "StopLogging" is called on a "cloudtrail" "trail"
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "event" is recorded
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "trail" is deleted then a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "event" is recorded
    Given tname in trail_status
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then a "cloudtrail" "trail" is created then "StartLogging" is called on a "cloudtrail" "trail"
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When a "cloudtrail" "trail" is created
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then "StartLogging" is called on a "cloudtrail" "trail" then "StopLogging" is called on a "cloudtrail" "trail"
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When "StartLogging" is called on a "cloudtrail" "trail"
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is deleted
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then a "cloudtrail" "trail" is deleted then a "cloudtrail" "event" is delivered to S3
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "event" is delivered to S3
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is recorded then a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "trail" is created
    Given eid not in event_status
    When a "cloudtrail" "event" is recorded
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "trail" is created then "StopLogging" is called on a "cloudtrail" "trail"
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "trail" is created
    When "StopLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then "StartLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "trail" is deleted
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When "StartLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "trail" is deleted
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then "StopLogging" is called on a "cloudtrail" "trail" then a "cloudtrail" "event" is recorded
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When "StopLogging" is called on a "cloudtrail" "trail"
    When a "cloudtrail" "event" is recorded
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "trail" is deleted then a "cloudtrail" "trail" is created
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "trail" is deleted
    When a "cloudtrail" "trail" is created
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @sequence
  Scenario: a "cloudtrail" "event" is delivered to S3 then a "cloudtrail" "event" is recorded then "StartLogging" is called on a "cloudtrail" "trail"
    Given eid in event_status
    When a "cloudtrail" "event" is delivered to S3
    When a "cloudtrail" "event" is recorded
    When "StartLogging" is called on a "cloudtrail" "trail"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)
