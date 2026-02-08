# eventbridge-provider Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: Event Bus
The EventBridge provider SHALL implement a local event bus that supports publishing events and matching them against rules defined in the CDK. The provider SHALL expose a FastAPI endpoint for `PutEvents` at the URL specified by `AWS_ENDPOINT_URL_EVENTBRIDGE`. Events SHALL be dispatched to matching rule targets via `asyncio.create_task` for non-blocking fan-out.

#### Scenario: Publish and match event
- **WHEN** a handler publishes an event with `source: "orders"` and `detail-type: "OrderCreated"` to the event bus, and a rule matches on `source: ["orders"]`
- **THEN** the rule's target Lambda handler SHALL be invoked with the event

#### Scenario: PutEvents API endpoint
- **WHEN** a handler sends a PutEvents request to the local EventBridge endpoint
- **THEN** the provider SHALL parse the AWS JSON request format, assign event IDs, evaluate all rules, and return the event IDs in the response

### Requirement: Event Pattern Matching
The provider SHALL support EventBridge event pattern syntax for matching events, including exact value matching, prefix matching, numeric range matching, `exists`/`anything-but` operators, and recursive matching for nested `detail` fields. The pattern matcher SHALL be implemented as a pure function `match_event(pattern, event) -> bool`.

#### Scenario: Pattern with multiple match criteria
- **WHEN** a rule has pattern `{"source": ["orders"], "detail-type": ["OrderCreated", "OrderUpdated"]}`
- **THEN** events with `source: "orders"` and either detail-type SHALL match, while events with `detail-type: "OrderDeleted"` SHALL NOT match

#### Scenario: Nested detail field matching
- **WHEN** a rule has pattern `{"detail": {"status": ["critical"]}}` and an event has `detail: {"status": "critical", "region": "us-east-1"}`
- **THEN** the event SHALL match because the nested field matches

### Requirement: Scheduled Rules
The provider SHALL support EventBridge scheduled rules using cron expressions (parsed via croniter) and rate expressions, invoking the target Lambda handler on schedule. Scheduling SHALL use an `asyncio.create_task` loop that sleeps until the next fire time.

#### Scenario: Cron-triggered handler
- **WHEN** a scheduled rule with `cron(0 9 * * *)` is defined in CDK
- **THEN** the target handler SHALL be invoked daily at the specified time during the local dev session

#### Scenario: Rate expression
- **WHEN** a scheduled rule with `rate(5 minutes)` is defined in CDK
- **THEN** the target handler SHALL be invoked every 5 minutes during the local dev session

### Requirement: Cross-Service Event Routing
The provider SHALL support routing events from other providers (such as S3 event notifications, DynamoDB stream events) through EventBridge to Lambda targets when configured in CDK. Provider-specific events SHALL be transformed into EventBridge event format with correct AWS source identifiers (e.g., `aws.s3`, `aws.dynamodb`).

#### Scenario: S3 event routed through EventBridge
- **WHEN** an S3 bucket is configured to send events to EventBridge and a rule matches S3 events
- **THEN** the target Lambda handler SHALL be invoked when objects are created in the bucket

