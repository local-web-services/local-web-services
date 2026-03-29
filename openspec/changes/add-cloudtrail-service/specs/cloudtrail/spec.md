## ADDED Requirements

### Requirement: CloudTrail Provider

The system SHALL provide a CloudTrail emulation provider that listens for AWS CloudTrail
wire-protocol requests (`X-Amz-Target: CloudTrail_20131101.*`) on a dedicated port and
responds with JSON payloads compatible with the AWS CloudTrail SDK.

#### Scenario: Provider accepts CloudTrail wire-protocol requests

- **WHEN** a POST request is sent with `X-Amz-Target: CloudTrail_20131101.DescribeTrails`
- **THEN** the provider returns a 200 response with a JSON body containing a `trailList` field

### Requirement: Trail Management

The system SHALL support creating, describing, and deleting CloudTrail trails.

#### Scenario: Create trail succeeds

- **WHEN** `CreateTrail` is called with a unique trail name and an S3 bucket name
- **THEN** the response contains the trail ARN and the trail is returned by `DescribeTrails`

#### Scenario: Create trail with duplicate name fails

- **WHEN** `CreateTrail` is called with a name that already exists
- **THEN** the response is an error with type `TrailAlreadyExistsException`

#### Scenario: Delete trail succeeds

- **WHEN** `DeleteTrail` is called for an existing trail
- **THEN** the trail is no longer returned by `DescribeTrails`

#### Scenario: Delete trail that does not exist fails

- **WHEN** `DeleteTrail` is called with a trail ARN or name that does not exist
- **THEN** the response is an error with type `TrailNotFoundException`

#### Scenario: GetTrail returns trail details

- **WHEN** `GetTrail` is called for an existing trail name
- **THEN** the response contains the trail configuration including name, ARN, and S3 bucket name

### Requirement: Logging State

The system SHALL track whether logging is enabled or disabled per trail and expose this
state via `GetTrailStatus`, `StartLogging`, and `StopLogging`.

#### Scenario: Logging is disabled by default

- **WHEN** a trail is created
- **THEN** `GetTrailStatus` returns `IsLogging: false`

#### Scenario: StartLogging enables logging

- **WHEN** `StartLogging` is called for an existing trail
- **THEN** `GetTrailStatus` returns `IsLogging: true`

#### Scenario: StopLogging disables logging

- **WHEN** `StopLogging` is called for a trail that has logging enabled
- **THEN** `GetTrailStatus` returns `IsLogging: false`

#### Scenario: StartLogging for non-existent trail fails

- **WHEN** `StartLogging` is called with a trail name that does not exist
- **THEN** the response is an error with type `TrailNotFoundException`

### Requirement: Event Selectors

The system SHALL accept event selector configuration per trail and return it unchanged.

#### Scenario: PutEventSelectors stores selectors

- **WHEN** `PutEventSelectors` is called with a list of event selectors for an existing trail
- **THEN** `GetEventSelectors` returns the same selectors for that trail

#### Scenario: GetEventSelectors for trail with no selectors

- **WHEN** `GetEventSelectors` is called for a trail with no configured selectors
- **THEN** the response contains an empty `EventSelectors` list

### Requirement: Event Recording and Lookup

The system SHALL record an event for each CloudTrail API call received and make those
events queryable via `LookupEvents`.

#### Scenario: LookupEvents returns recorded events

- **WHEN** one or more CloudTrail API calls have been made
- **THEN** `LookupEvents` returns a list containing an entry for each recorded call

#### Scenario: LookupEvents with attribute filter

- **WHEN** `LookupEvents` is called with a `LookupAttributes` filter on `EventName`
- **THEN** only events matching that `EventName` are returned

#### Scenario: LookupEvents with MaxResults

- **WHEN** `LookupEvents` is called with `MaxResults` set to N and more than N events exist
- **THEN** the response contains at most N events and a `NextToken` for pagination

#### Scenario: LookupEvents with NextToken

- **WHEN** `LookupEvents` is called with a `NextToken` returned from a previous call
- **THEN** the response returns the next page of events starting after the previous page

### Requirement: SDK Endpoint Redirection

The system SHALL set `AWS_ENDPOINT_URL_CLOUDTRAIL` in the Lambda execution environment
so that Lambda functions using the AWS CloudTrail SDK are automatically redirected to the
local CloudTrail provider.

#### Scenario: CloudTrail SDK calls from Lambda are redirected

- **WHEN** a Lambda function calls the CloudTrail SDK (e.g. `LookupEvents`)
- **THEN** the call is served by the local CloudTrail provider, not the real AWS endpoint

### Requirement: CloudTrail lws CLI Commands

The system SHALL provide `lws cloudtrail` sub-commands compatible with the AWS CLI interface
for interacting with the CloudTrail provider from the terminal.

#### Scenario: lws cloudtrail create-trail

- **WHEN** `lws cloudtrail create-trail --name my-trail --s3-bucket-name my-bucket` is run
- **THEN** the trail is created and its ARN is printed

#### Scenario: lws cloudtrail describe-trails

- **WHEN** `lws cloudtrail describe-trails` is run
- **THEN** all configured trails are listed with their names and ARNs

#### Scenario: lws cloudtrail get-trail-status

- **WHEN** `lws cloudtrail get-trail-status --name my-trail` is run
- **THEN** the logging status (`IsLogging: true/false`) is printed

#### Scenario: lws cloudtrail lookup-events

- **WHEN** `lws cloudtrail lookup-events` is run
- **THEN** the list of recorded CloudTrail events is printed in JSON format
