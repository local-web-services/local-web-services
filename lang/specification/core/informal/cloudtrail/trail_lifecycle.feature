@cloudtrail @generated
Feature: CloudTrail - Trail Lifecycle

  # Generated from FizzBee spec: cloudtrail.fizz
  # Safety invariants: CapacityLimitRespected, TrailCountConsistent, DeletedTrailNotLogging

  Background:
    Given the system is initialized

  @minimal @happy @create_trail
  Scenario: a cloudtrail trail is created
    Given the cloudtrail trail did not already exist
    And the active trail count is below the maximum (5)
    When a cloudtrail trail is created
    Then the cloudtrail trail will be "CREATED"
    And the capacity limit is respected
    And the trail count is consistent

  @guard @negative @create_trail
  Scenario: a cloudtrail trail is created fails when the cloudtrail trail already existed
    Given the cloudtrail trail already existed
    When a cloudtrail trail is created
    Then the operation is rejected

  @guard @negative @create_trail
  Scenario: a cloudtrail trail is created fails when the capacity limit is reached
    Given the active trail count has reached the maximum (5)
    When a cloudtrail trail is created
    Then the operation is rejected

  @minimal @happy @start_logging
  Scenario: StartLogging is called on a cloudtrail trail
    Given the cloudtrail trail existed
    And the cloudtrail trail was not "DELETED"
    When StartLogging is called on the cloudtrail trail
    Then the cloudtrail trail logging will be enabled
    And a deleted trail is never in logging state

  @guard @negative @start_logging
  Scenario: StartLogging fails when the cloudtrail trail does not exist
    Given the cloudtrail trail did not exist
    When StartLogging is called on the cloudtrail trail
    Then the operation is rejected

  @minimal @happy @stop_logging
  Scenario: StopLogging is called on a cloudtrail trail
    Given the cloudtrail trail existed
    And the cloudtrail trail was "LOGGING"
    When StopLogging is called on the cloudtrail trail
    Then the cloudtrail trail logging will be disabled
    And a deleted trail is never in logging state

  @guard @negative @stop_logging
  Scenario: StopLogging fails when the cloudtrail trail was not logging
    Given the cloudtrail trail was not "LOGGING"
    When StopLogging is called on the cloudtrail trail
    Then the operation is rejected

  @minimal @happy @delete_trail
  Scenario: a cloudtrail trail is deleted
    Given the cloudtrail trail existed
    When a cloudtrail trail is deleted
    Then the cloudtrail trail will be "DELETED"
    And the capacity limit is respected
    And the trail count is consistent
    And a deleted trail is never in logging state

  @guard @negative @delete_trail
  Scenario: a cloudtrail trail is deleted fails when the cloudtrail trail did not exist
    Given the cloudtrail trail did not exist
    When a cloudtrail trail is deleted
    Then the operation is rejected

  @minimal @happy @get_trail
  Scenario: GetTrail returns the trail configuration
    Given a cloudtrail trail has been created
    When GetTrail is called with the trail name
    Then the trail configuration and logging state are returned

  @minimal @happy @list_trails
  Scenario: ListTrails returns all trails
    Given two cloudtrail trails have been created
    When ListTrails is called
    Then both trails are included in the response

  @guard @negative @get_trail
  Scenario: GetTrail fails when the trail does not exist
    Given no cloudtrail trail has been created with that name
    When GetTrail is called with the trail name
    Then the operation is rejected

  @minimal @happy @get_trail_status
  Scenario: GetTrailStatus reflects logging state after StartLogging
    Given a cloudtrail trail has been created
    And StartLogging has been called on the trail
    When GetTrailStatus is called
    Then IsLogging is true

  @minimal @happy @update_trail
  Scenario: UpdateTrail changes the S3 bucket
    Given a cloudtrail trail has been created
    When UpdateTrail is called with a new S3 bucket name
    Then the trail's S3 bucket is updated

  @minimal @happy @update_trail_eventbridge
  Scenario: UpdateTrail enables EventBridge forwarding
    Given a cloudtrail trail has been created
    When UpdateTrail is called with an EventBridgeEventBusArn
    Then subsequent events are forwarded to EventBridge
