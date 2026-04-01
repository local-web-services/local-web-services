## ADDED Requirements

### Requirement: Periodic S3 Log Delivery
The system SHALL flush buffered CloudTrail events to the trail's configured S3 bucket
on a 5-minute interval. Log files SHALL be written as gzip-compressed JSON with the
structure `{"Records": [...]}` and placed under the standard CloudTrail S3 key path:
```
<prefix>/AWSLogs/<account-id>/CloudTrail/<region>/<YYYY>/<MM>/<DD>/
  <account-id>_CloudTrail_<region>_<YYYYMMDDTHHMMSS>Z_<random8>.json.gz
```
Only trails in LOGGING state SHALL receive S3 delivery.

#### Scenario: Events flushed to S3 on schedule
- **WHEN** a trail is in LOGGING state and 5 minutes have elapsed since the last flush
- **THEN** all buffered events are written to the S3 bucket as a gzip log file and the buffer is cleared

#### Scenario: STOPPED trail receives no S3 delivery
- **WHEN** a trail is in STOPPED state
- **THEN** no S3 log files are written even if events accumulate in the internal buffer

#### Scenario: Log file format is valid CloudTrail JSON
- **WHEN** an S3 log file is downloaded and decompressed
- **THEN** it is valid JSON with a top-level `Records` array where each element is a valid CloudTrail event

### Requirement: S3 Delivery Error Handling
The system SHALL record S3 delivery failures (e.g., bucket does not exist) in the trail's
status as `LatestDeliveryError`. Delivery SHALL be retried on the next flush cycle.
Delivery failures SHALL NOT affect the event buffer or the operation of the emulated
services.

#### Scenario: Delivery error recorded in trail status
- **WHEN** the configured S3 bucket does not exist and a flush is attempted
- **THEN** `GetTrailStatus` returns a `LatestDeliveryError` describing the failure

#### Scenario: Delivery succeeds after bucket is created
- **WHEN** the S3 bucket is created after a prior delivery failure
- **THEN** the next scheduled flush succeeds and `LatestDeliveryError` is cleared

### Requirement: S3 Bucket Validation on Trail Creation
The system SHALL NOT require the S3 bucket to exist at `CreateTrail` time (matching
real AWS CloudTrail behaviour). Bucket existence is validated at delivery time only.

#### Scenario: Trail created with non-existent bucket
- **WHEN** `CreateTrail` specifies a bucket that does not yet exist in the S3 provider
- **THEN** the trail is created successfully; the error is deferred to first delivery attempt
