## ADDED Requirements

### Requirement: Event Bus
The EventBridge provider SHALL implement a local event bus that supports publishing events and matching them against rules defined in the CDK.

#### Scenario: Publish and match event
- **WHEN** a handler publishes an event with `source: "orders"` and `detail-type: "OrderCreated"` to the event bus, and a rule matches on `source: ["orders"]`
- **THEN** the rule's target Lambda handler SHALL be invoked with the event

### Requirement: Event Pattern Matching
The provider SHALL support EventBridge event pattern syntax for matching events, including exact value matching, prefix matching, and numeric range matching on event fields.

#### Scenario: Pattern with multiple match criteria
- **WHEN** a rule has pattern `{"source": ["orders"], "detail-type": ["OrderCreated", "OrderUpdated"]}`
- **THEN** events with `source: "orders"` and either detail-type SHALL match, while events with `detail-type: "OrderDeleted"` SHALL NOT match

### Requirement: Scheduled Rules
The provider SHALL support EventBridge scheduled rules using cron expressions (parsed via croniter), invoking the target Lambda handler on schedule.

#### Scenario: Cron-triggered handler
- **WHEN** a scheduled rule with `cron(0 9 * * *)` is defined in CDK
- **THEN** the target handler SHALL be invoked daily at the specified time during the local dev session

### Requirement: Cross-Service Event Routing
The provider SHALL support routing events from other services (such as S3 events) through EventBridge to Lambda targets when configured in CDK.

#### Scenario: S3 event routed through EventBridge
- **WHEN** an S3 bucket is configured to send events to EventBridge and a rule matches S3 events
- **THEN** the target Lambda handler SHALL be invoked when objects are created in the bucket
