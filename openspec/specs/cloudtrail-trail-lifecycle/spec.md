# cloudtrail-trail-lifecycle Specification

## Purpose
TBD - created by archiving change add-cloudtrail-emulation. Update Purpose after archive.
## Requirements
### Requirement: Trail Creation
The system SHALL allow a caller to create a named CloudTrail trail via `CreateTrail`,
specifying at minimum a trail name and an S3 bucket for log delivery. The trail SHALL
be created in the CREATED/STOPPED state (logging not yet active). A maximum of 5 trails
MAY exist at any one time; exceeding this limit SHALL raise `MaximumNumberOfTrailsExceededException`.

#### Scenario: Trail created successfully
- **WHEN** `CreateTrail` is called with a unique name and valid S3 bucket
- **THEN** the trail is created in STOPPED state and the trail ARN is returned

#### Scenario: Duplicate trail name rejected
- **WHEN** `CreateTrail` is called with a name that already exists
- **THEN** `TrailAlreadyExistsException` is returned

#### Scenario: Capacity limit enforced
- **WHEN** 5 trails already exist and `CreateTrail` is called for a sixth
- **THEN** `MaximumNumberOfTrailsExceededException` is returned

### Requirement: Trail Logging Control
The system SHALL support `StartLogging` and `StopLogging` operations that transition
a trail between LOGGING and STOPPED states. Only a trail in STOPPED state MAY be
started; only a trail in LOGGING state MAY be stopped.

#### Scenario: Trail starts logging
- **WHEN** `StartLogging` is called on a STOPPED trail
- **THEN** the trail transitions to LOGGING state and subsequent API calls generate events

#### Scenario: Trail stops logging
- **WHEN** `StopLogging` is called on a LOGGING trail
- **THEN** the trail transitions to STOPPED state and new API calls do not generate events

#### Scenario: Start on already-logging trail is idempotent
- **WHEN** `StartLogging` is called on a trail already in LOGGING state
- **THEN** no error is returned and the trail remains in LOGGING state

### Requirement: Trail Update
The system SHALL allow `UpdateTrail` to change the S3 bucket, S3 key prefix, and
EventBridge event bus ARN of an existing trail. The trail MAY be in any non-DELETED state.

#### Scenario: S3 bucket updated
- **WHEN** `UpdateTrail` is called with a new S3 bucket name
- **THEN** subsequent log deliveries target the new bucket

#### Scenario: EventBridge bus ARN updated
- **WHEN** `UpdateTrail` is called with a new `EventBridgeEventBusArn`
- **THEN** subsequent CloudTrail events are forwarded to the named bus

### Requirement: Trail Deletion
The system SHALL allow `DeleteTrail` to permanently remove a trail. A LOGGING trail
SHALL be stopped before deletion. Deleting a non-existent trail SHALL raise `TrailNotFoundException`.

#### Scenario: Trail deleted successfully
- **WHEN** `DeleteTrail` is called on an existing trail
- **THEN** the trail is removed; `GetTrail` for that name returns `TrailNotFoundException`

#### Scenario: Delete non-existent trail rejected
- **WHEN** `DeleteTrail` is called with an unknown trail name
- **THEN** `TrailNotFoundException` is returned

### Requirement: Trail Retrieval
The system SHALL support `GetTrail` (single trail by name or ARN) and `ListTrails`
(all trails). Both operations SHALL work regardless of the trail's logging state.

#### Scenario: Get trail by name
- **WHEN** `GetTrail` is called with an existing trail name
- **THEN** the full trail configuration including logging state is returned

#### Scenario: List trails returns all trails
- **WHEN** `ListTrails` is called with no filters
- **THEN** all trails including their ARNs and home regions are returned

#### Scenario: Get non-existent trail rejected
- **WHEN** `GetTrail` is called with an unknown name
- **THEN** `TrailNotFoundException` is returned

### Requirement: Trail Logging Status
The system SHALL support `GetTrailStatus` which returns whether a trail is currently
logging, the time logging was last started and stopped, and any latest delivery error.

#### Scenario: Logging status reflects current state
- **WHEN** `GetTrailStatus` is called after `StartLogging`
- **THEN** `IsLogging` is `true` and `LatestDeliveryTime` is populated after the first S3 flush

