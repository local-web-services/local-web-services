@cloudtrail @generated
Feature: Cloudtrail - "Startlogging" Is Called On A "Cloudtrail" "Trail"

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: CapacityLimitRespected, TrailCountConsistent, DeletedTrailNotLogging, EventsReferValidTrails, DeliveredEventsFromLoggingTrails

  Background:
    Given the system is initialized

  @minimal @happy @start_logging
  Scenario: "StartLogging" is called on a "cloudtrail" "trail"
    Given the "cloudtrail" "trail" existed
    And the "cloudtrail" "trail" was not "DELETED"
    When "StartLogging" is called on a "cloudtrail" "trail"
    Then the "cloudtrail" "trail" will be "LOGGING"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @guard @negative @start_logging
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" fails when the "cloudtrail" "trail" did not exist
    Given the "cloudtrail" "trail" did not exist
    When "StartLogging" is called on a "cloudtrail" "trail"
    Then the operation is rejected

  @guard @negative @start_logging
  Scenario: "StartLogging" is called on a "cloudtrail" "trail" fails when the "cloudtrail" "trail" was "DELETED"
    Given the "cloudtrail" "trail" existed
    And the "cloudtrail" "trail" was "DELETED"
    When "StartLogging" is called on a "cloudtrail" "trail"
    Then the operation is rejected
