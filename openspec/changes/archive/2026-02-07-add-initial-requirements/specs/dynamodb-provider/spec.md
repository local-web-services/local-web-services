## ADDED Requirements

### Requirement: Table Creation
The DynamoDB provider SHALL create local tables matching the CDK-defined key schema (partition key and optional sort key) using SQLite as the backing store.

#### Scenario: Create table with composite key
- **WHEN** the CDK defines a DynamoDB table with partition key `orderId (S)` and sort key `timestamp (N)`
- **THEN** a local SQLite table SHALL be created that supports operations using this key schema

### Requirement: Basic CRUD Operations
The provider SHALL support GetItem, PutItem, DeleteItem, and UpdateItem operations via the DynamoDB API.

#### Scenario: Put and get item
- **WHEN** a handler calls `dynamodb.putItem()` followed by `dynamodb.getItem()` with the same key
- **THEN** the get operation SHALL return the item that was put

### Requirement: Query Operations
The provider SHALL support Query operations against the table's primary key and sort key with key condition expressions.

#### Scenario: Query by partition key with sort key condition
- **WHEN** a handler queries with `KeyConditionExpression: "orderId = :id AND timestamp > :ts"`
- **THEN** the query SHALL return all items matching the partition key with timestamp greater than the specified value, ordered by sort key

### Requirement: Scan Operations
The provider SHALL support Scan operations with optional FilterExpression evaluation.

#### Scenario: Scan with filter
- **WHEN** a handler scans a table with `FilterExpression: "status = :s"` where `:s` is `"active"`
- **THEN** the scan SHALL return only items where the `status` attribute equals `"active"`

### Requirement: Global Secondary Indexes
The provider SHALL support GSI queries with the key schema and projection defined in CDK.

#### Scenario: Query GSI
- **WHEN** the CDK defines a GSI `customerId-index` with partition key `customerId` and a handler queries against it
- **THEN** the query SHALL return items matching the GSI partition key

### Requirement: Update Expressions
The provider SHALL support SET, REMOVE, ADD, and DELETE update expression operations.

#### Scenario: Complex update expression
- **WHEN** a handler calls `updateItem` with `UpdateExpression: "SET #s = :s, #q = #q + :inc REMOVE #old"`
- **THEN** the item SHALL be updated with the new status, incremented quantity, and removed attribute

### Requirement: Batch Operations
The provider SHALL support BatchGetItem and BatchWriteItem operations with the 25-item limit per batch.

#### Scenario: Batch write items
- **WHEN** a handler calls `batchWriteItem` with 10 put requests
- **THEN** all 10 items SHALL be written to the table

### Requirement: DynamoDB Streams
The provider SHALL emit change events (INSERT, MODIFY, REMOVE) for item modifications and deliver them to connected Lambda handlers via event source mapping.

#### Scenario: Stream triggers handler on item change
- **WHEN** a handler puts an item into a table that has DynamoDB Streams enabled and a connected Lambda
- **THEN** the stream-connected Lambda SHALL be invoked with a DynamoDB Streams event record containing the new item image

### Requirement: Eventual Consistency Simulation
The DynamoDB provider SHALL simulate eventual consistency where AWS DynamoDB exhibits it. Eventually consistent reads and GSI queries SHALL serve data with a configurable delay after writes. The default delay SHALL be 200 milliseconds. Strongly consistent reads (`ConsistentRead: true`) SHALL return the latest data immediately.

#### Scenario: Eventually consistent read returns stale data within delay window
- **WHEN** a handler writes an item and immediately performs an eventually consistent read (default `ConsistentRead: false`) within the configured delay window
- **THEN** the read MAY return stale data (the item may not yet be visible)

#### Scenario: Strongly consistent read returns latest data
- **WHEN** a handler writes an item and immediately performs a read with `ConsistentRead: true`
- **THEN** the read SHALL return the latest written data regardless of the delay window

#### Scenario: GSI query eventual consistency
- **WHEN** a handler writes an item and immediately queries a GSI
- **THEN** the GSI query MAY return stale results within the configured delay window

#### Scenario: Configurable delay
- **WHEN** a developer sets the eventual consistency delay to 500ms in configuration
- **THEN** eventually consistent reads SHALL use the 500ms delay instead of the 200ms default

### Requirement: State Persistence
The DynamoDB provider SHALL persist table data to disk using SQLite (via aiosqlite) so that data survives between `ldk dev` sessions.

#### Scenario: Data persists across restarts
- **WHEN** a developer puts items into a table, stops `ldk dev`, and starts it again
- **THEN** the previously stored items SHALL be retrievable
