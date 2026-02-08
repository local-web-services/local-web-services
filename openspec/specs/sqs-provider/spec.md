# sqs-provider Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: Message Send and Receive
The SQS provider SHALL support SendMessage and ReceiveMessage operations with visibility timeout handling. The in-memory queue SHALL use `asyncio.Lock` for concurrency safety across all queue operations. Queue state SHALL be persisted to disk using aiosqlite so that pending and in-flight messages survive between `ldk dev` sessions. On startup, messages SHALL be loaded from the SQLite database. On shutdown, all in-memory state SHALL be flushed to the SQLite database. Messages that were in-flight at shutdown SHALL become visible again on restart (visibility timeout reset).

#### Scenario: Send and receive message
- **WHEN** a handler sends a message to a queue and another handler receives from the queue
- **THEN** the received message SHALL contain the sent message body and attributes

#### Scenario: Concurrent queue access is safe
- **WHEN** multiple async tasks send and receive messages simultaneously
- **THEN** all operations SHALL complete without data corruption due to the `asyncio.Lock` protecting queue state

#### Scenario: Queue state persists across restarts
- **WHEN** a developer sends messages to a queue, stops `ldk dev`, and starts it again
- **THEN** the previously sent messages SHALL be available for receive operations after restart

### Requirement: Message Deletion
The provider SHALL support DeleteMessage using the receipt handle returned from ReceiveMessage.

#### Scenario: Delete received message
- **WHEN** a handler receives a message and then deletes it using the receipt handle
- **THEN** the message SHALL not be redelivered on subsequent receive calls

### Requirement: Visibility Timeout
The provider SHALL implement visibility timeout so that received but undeleted messages become visible again after the timeout period.

#### Scenario: Message redelivered after visibility timeout
- **WHEN** a message is received but not deleted, and the visibility timeout expires
- **THEN** the message SHALL become available for redelivery on the next receive call

### Requirement: Lambda Event Source Mapping
The provider SHALL poll the queue and invoke the configured Lambda handler with an SQS event batch when messages are available.

#### Scenario: Auto-trigger handler on message arrival
- **WHEN** a message is sent to a queue that has a Lambda event source mapping
- **THEN** the configured handler SHALL be automatically invoked with an SQS event containing the message, respecting the configured batch size

### Requirement: Dead Letter Queue
The provider SHALL route failed messages to a configured dead letter queue after the message has been received `maxReceiveCount` times without being deleted.

#### Scenario: Message moved to DLQ after max retries
- **WHEN** a handler fails to process a message (throws an error) and the message has been received `maxReceiveCount` times
- **THEN** the message SHALL appear in the configured DLQ and SHALL NOT be redelivered to the primary queue

### Requirement: FIFO Queue Support
The provider SHALL support FIFO queue semantics including MessageGroupId ordering and MessageDeduplicationId handling.

#### Scenario: FIFO ordering within message group
- **WHEN** messages A, B, C are sent to a FIFO queue with the same MessageGroupId
- **THEN** they SHALL be delivered in order A, B, C

#### Scenario: FIFO deduplication
- **WHEN** two messages with the same MessageDeduplicationId are sent within the deduplication window
- **THEN** only one copy SHALL be delivered

