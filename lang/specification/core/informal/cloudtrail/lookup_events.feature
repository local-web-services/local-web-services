@cloudtrail @generated
Feature: CloudTrail - LookupEvents

  Background:
    Given the system is initialized
    And a cloudtrail trail has been created
    And StartLogging has been called on the trail
    And several service API calls have been made

  @minimal @happy @filter_by_event_name
  Scenario: LookupEvents filters by event name
    Given events for CreateQueue and CreateTable are in the buffer
    When LookupEvents is called with AttributeKey EventName and AttributeValue CreateQueue
    Then only CreateQueue events are returned
    And no CreateTable events are included

  @minimal @happy @filter_by_resource_type
  Scenario: LookupEvents filters by resource type
    Given S3 and DynamoDB events are in the buffer
    When LookupEvents is called with AttributeKey ResourceType and AttributeValue AWS::S3::Bucket
    Then only events with S3 bucket resources are returned

  @minimal @happy @filter_by_username
  Scenario: LookupEvents filters by username
    Given events from two different callers are in the buffer
    When LookupEvents is called with AttributeKey Username and AttributeValue developer
    Then only events with userIdentity.userName equal to developer are returned

  @minimal @happy @filter_by_event_source
  Scenario: LookupEvents filters by event source
    Given events from multiple services are in the buffer
    When LookupEvents is called with AttributeKey EventSource and AttributeValue sqs.amazonaws.com
    Then only SQS events are returned

  @minimal @happy @time_range_filter
  Scenario: LookupEvents applies a time range filter
    Given events were captured over a 30-minute period
    When LookupEvents is called with StartTime and EndTime bounding a 10-minute window
    Then only events with eventTime within that window are returned

  @minimal @happy @no_time_range
  Scenario: LookupEvents returns all events when no time range is specified
    Given multiple events are in the buffer
    When LookupEvents is called without StartTime or EndTime
    Then all matching buffered events are returned

  @minimal @happy @reverse_chronological
  Scenario: LookupEvents returns events newest first
    Given events were captured at different times
    When LookupEvents is called
    Then events are returned in reverse-chronological order

  @minimal @happy @pagination
  Scenario: LookupEvents paginates large result sets
    Given more than 50 matching events are in the buffer
    When LookupEvents is called without a NextToken
    Then 50 events are returned
    And a NextToken is included in the response

  @minimal @happy @next_page
  Scenario: LookupEvents retrieves the next page using NextToken
    Given a prior LookupEvents response returned a NextToken
    When LookupEvents is called with that NextToken
    Then the next page of events is returned

  @minimal @happy @no_trails_logging
  Scenario: LookupEvents works even when no trail is logging
    Given no trail is in logging state
    And events are in the internal buffer
    When LookupEvents is called
    Then buffered events are returned
