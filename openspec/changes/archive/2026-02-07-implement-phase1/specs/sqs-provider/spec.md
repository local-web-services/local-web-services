## MODIFIED Requirements
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
