# cloudtrail-event-capture Specification

## Purpose
TBD - created by archiving change add-cloudtrail-emulation. Update Purpose after archive.
## Requirements
### Requirement: Management Event Capture
The system SHALL capture management events (control-plane API calls) for all 21 supported
AWS service providers via `AwsCloudTrailMiddleware`. Each captured event SHALL include
the full CloudTrail event envelope: `eventVersion`, `userIdentity`, `eventTime`,
`eventSource`, `eventName`, `awsRegion`, `sourceIPAddress`, `requestParameters`,
`responseElements`, `errorCode` (if applicable), `errorMessage` (if applicable),
`eventType`, `eventID`, and `recipientAccountId`.

#### Scenario: Successful management event captured
- **WHEN** a caller invokes `CreateQueue` on the SQS provider
- **THEN** a CloudTrail management event with `eventName: CreateQueue`, `eventSource: sqs.amazonaws.com`, and no `errorCode` is buffered

#### Scenario: Failed management event captured with error
- **WHEN** a caller invokes an operation that returns an AWS error (e.g., `ResourceNotFoundException`)
- **THEN** a CloudTrail event is buffered with `errorCode` and `errorMessage` populated

#### Scenario: IAM-denied call captured
- **WHEN** an operation is denied by `AwsIamAuthMiddleware`
- **THEN** a CloudTrail event is buffered with `errorCode: AccessDenied`

#### Scenario: Chaos-injected error captured
- **WHEN** `AwsChaosMiddleware` injects an error response for an operation
- **THEN** a CloudTrail event is buffered recording the injected error code

### Requirement: Data Event Capture
The system SHALL capture data events (data-plane API calls) in addition to management
events. For S3, data events include `GetObject`, `PutObject`, `DeleteObject`. For DynamoDB,
data events include `GetItem`, `PutItem`, `UpdateItem`, `DeleteItem`, `Query`, `Scan`.
Data events SHALL be distinguished from management events via `eventType: AwsApiCall`
with the resource ARN populated in `resources`.

#### Scenario: S3 data event captured
- **WHEN** a caller invokes `PutObject` on the S3 provider
- **THEN** a CloudTrail data event is buffered with `eventName: PutObject`,
  `eventSource: s3.amazonaws.com`, and `resources` containing the object ARN

#### Scenario: DynamoDB data event captured
- **WHEN** a caller invokes `PutItem` on the DynamoDB provider
- **THEN** a CloudTrail data event is buffered with `eventName: PutItem`,
  `eventSource: dynamodb.amazonaws.com`, and the table ARN in `resources`

### Requirement: Event Buffer Management
The system SHALL maintain an in-memory ring buffer of captured events per trail (default
capacity: 10,000 events). When the buffer reaches its high-water mark (1,000 events) a
flush to S3 SHALL be triggered. The buffer capacity SHALL be configurable. When all trails
are in STOPPED state the middleware SHALL still capture events to the internal buffer
(enabling `LookupEvents` to work without S3 delivery).

#### Scenario: Buffer high-water mark triggers flush
- **WHEN** 1,000 events accumulate without a scheduled flush
- **THEN** an S3 flush is triggered and the buffer is cleared

#### Scenario: Events available in buffer when no trails logging
- **WHEN** no trail is in LOGGING state
- **THEN** events are still buffered internally and queryable via `LookupEvents`

### Requirement: Middleware No-Op When Provider Absent
The system SHALL NOT require a `CloudTrailProvider` to be running in order for the
other 21 providers to function. If no `CloudTrailProvider` is registered in the
orchestrator, `AwsCloudTrailMiddleware` SHALL silently skip event recording.

#### Scenario: Service works without CloudTrail provider
- **WHEN** `CloudTrailProvider` is not started and a DynamoDB call is made
- **THEN** the DynamoDB call succeeds normally and no error is raised

