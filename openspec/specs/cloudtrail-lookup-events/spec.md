# cloudtrail-lookup-events Specification

## Purpose
TBD - created by archiving change add-cloudtrail-emulation. Update Purpose after archive.
## Requirements
### Requirement: Event Lookup with Filters
The system SHALL implement `LookupEvents` that searches the in-memory event buffer
and returns matching CloudTrail events. The operation SHALL support the following
`LookupAttributes` filter keys (matching real AWS CloudTrail): `EventId`, `EventName`,
`ReadOnly`, `Username`, `ResourceType`, `ResourceName`, `EventSource`, and `AccessKeyId`.
Results SHALL be returned in reverse-chronological order (newest first). A maximum of
50 events SHALL be returned per page (matching the real API default).

#### Scenario: Filter by event name
- **WHEN** `LookupEvents` is called with `LookupAttributes: [{AttributeKey: EventName, AttributeValue: CreateQueue}]`
- **THEN** only events with `eventName: CreateQueue` are returned

#### Scenario: Filter by resource type
- **WHEN** `LookupEvents` is called with `AttributeKey: ResourceType` and `AttributeValue: AWS::S3::Bucket`
- **THEN** only events whose `resources` array contains a resource of type `AWS::S3::Bucket` are returned

#### Scenario: Filter by username
- **WHEN** `LookupEvents` is called with `AttributeKey: Username` and `AttributeValue: developer`
- **THEN** only events where `userIdentity.userName` equals `developer` are returned

### Requirement: Time-Range Filtering
The system SHALL support `StartTime` and `EndTime` parameters on `LookupEvents` to
restrict results to events within a given time window. Both parameters are optional;
omitting them returns all events in the buffer.

#### Scenario: Time range applied
- **WHEN** `LookupEvents` is called with `StartTime` and `EndTime` bounding a 10-minute window
- **THEN** only events with `eventTime` within that window are returned

#### Scenario: No time range returns all events
- **WHEN** `LookupEvents` is called without `StartTime` or `EndTime`
- **THEN** all buffered events matching any other filters are returned

### Requirement: Pagination
The system SHALL support cursor-based pagination via `NextToken`. When the result set
exceeds the page size, a `NextToken` SHALL be returned. Passing this token in a
subsequent `LookupEvents` call SHALL return the next page.

#### Scenario: Large result set paginated
- **WHEN** more than 50 events match and `LookupEvents` is called without a token
- **THEN** 50 events and a `NextToken` are returned

#### Scenario: Next page retrieved via token
- **WHEN** `LookupEvents` is called with the `NextToken` from a prior response
- **THEN** the next page of matching events is returned

