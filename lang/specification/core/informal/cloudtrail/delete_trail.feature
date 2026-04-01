@cloudtrail @generated
Feature: Cloudtrail - A "Cloudtrail" "Trail" Is Deleted

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: CapacityLimitRespected, TrailCountConsistent, DeletedTrailNotLogging, EventsReferValidTrails, DeliveredEventsFromLoggingTrails

  Background:
    Given the system is initialized

  @minimal @happy @delete_trail
  Scenario: a "cloudtrail" "trail" is deleted
    Given the "cloudtrail" "trail" existed
    When a "cloudtrail" "trail" is deleted
    Then the "cloudtrail" "trail" will be "DELETED"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @guard @negative @delete_trail
  Scenario: a "cloudtrail" "trail" is deleted fails when the "cloudtrail" "trail" did not exist
    Given the "cloudtrail" "trail" did not exist
    When a "cloudtrail" "trail" is deleted
    Then the operation is rejected
