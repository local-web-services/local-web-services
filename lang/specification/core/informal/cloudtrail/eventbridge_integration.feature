@cloudtrail @generated
Feature: CloudTrail - EventBridge Integration

  Background:
    Given the system is initialized
    And an EventBridge event bus exists

  @minimal @happy @forwarding_opt_in
  Scenario: events are forwarded to EventBridge when bus ARN is configured
    Given a cloudtrail trail has been created with an EventBridgeEventBusArn
    And StartLogging has been called on the trail
    When a service API call is made
    Then an EventBridge event is published to the configured bus
    And the EventBridge event has Source aws.cloudtrail
    And the EventBridge event has DetailType "AWS API Call via CloudTrail"
    And the EventBridge event Detail contains the full CloudTrail event JSON

  @minimal @happy @eventbridge_rule_reaction
  Scenario: an EventBridge rule fires when a matching CloudTrail event arrives
    Given a cloudtrail trail with EventBridgeEventBusArn is logging
    And an EventBridge rule matches on source aws.cloudtrail and detail.eventName CreateBucket
    When CreateBucket is called on the S3 provider
    Then the EventBridge rule target is invoked

  @minimal @happy @missing_bus_skipped
  Scenario: missing EventBridge bus is silently skipped
    Given a cloudtrail trail is configured with an EventBridgeEventBusArn that does not exist
    And StartLogging has been called on the trail
    When a service API call is made
    Then a warning is logged
    And no error is raised
    And event capture continues normally

  @minimal @happy @no_forwarding_by_default
  Scenario: no EventBridge events are sent when no bus ARN is configured
    Given a cloudtrail trail has been created without EventBridgeEventBusArn
    And StartLogging has been called on the trail
    When a service API call is made
    Then no EventBridge PutEvents call is made

  @minimal @happy @forwarding_enabled_via_update
  Scenario: EventBridge forwarding is enabled via UpdateTrail
    Given a cloudtrail trail has been created without EventBridgeEventBusArn
    And StartLogging has been called on the trail
    When UpdateTrail is called with an EventBridgeEventBusArn
    And a service API call is made
    Then an EventBridge event is published to the configured bus

  @minimal @happy @forwarding_disabled_via_update
  Scenario: EventBridge forwarding is disabled by clearing the bus ARN
    Given a cloudtrail trail with EventBridgeEventBusArn is logging
    When UpdateTrail is called with an empty EventBridgeEventBusArn
    And a service API call is made
    Then no EventBridge PutEvents call is made
