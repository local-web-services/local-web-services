@cloudtrail @generated
Feature: Cloudtrail - A "Cloudtrail" "Trail" Is Created

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: CapacityLimitRespected, TrailCountConsistent, DeletedTrailNotLogging, EventsReferValidTrails, DeliveredEventsFromLoggingTrails

  Background:
    Given the system is initialized

  @minimal @happy @create_trail
  Scenario: a "cloudtrail" "trail" is created
    Given the "cloudtrail" "trail" did not already exist
    And the "cloudtrail" "trail" count is below the maximum (5)
    When a "cloudtrail" "trail" is created
    Then the "cloudtrail" "trail" will be "CREATED"
    And the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"
    And the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s
    And a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state
    And every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"
    And "cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)

  @guard @negative @create_trail
  Scenario: a "cloudtrail" "trail" is created fails when the "cloudtrail" "trail" already existed
    Given the "cloudtrail" "trail" already existed
    When a "cloudtrail" "trail" is created
    Then the operation is rejected

  @guard @negative @create_trail @capacity
  Scenario: a "cloudtrail" "trail" is created fails when the "cloudtrail" "trail" count has reached the maximum (5)
    Given the "cloudtrail" "trail" did not already exist
    And the "cloudtrail" "trail" count has reached the maximum (5)
    When a "cloudtrail" "trail" is created
    Then the operation is rejected
