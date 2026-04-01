## ADDED Requirements

### Requirement: RDS Data API

The RDS provider SHALL implement the RDS Data API: `execute_statement`, `batch_execute_statement`, `begin_transaction`, `commit_transaction`, and `rollback_transaction`. All SQL execution SHALL use an in-memory SQLite engine scoped to the cluster, requiring no external database.

#### Scenario: SQL SELECT returns rows

- **GIVEN** a table has been created and populated via `execute_statement`
- **WHEN** `execute_statement` is called with a SELECT query
- **THEN** the matching rows are returned in RDS Data API record format

#### Scenario: Transaction commit persists data

- **GIVEN** a transaction is started via `begin_transaction`
- **WHEN** INSERT statements are executed and `commit_transaction` is called
- **THEN** the inserted rows are visible in subsequent queries

#### Scenario: Transaction rollback discards data

- **GIVEN** a transaction is started and rows are inserted
- **WHEN** `rollback_transaction` is called
- **THEN** the inserted rows are not visible in subsequent queries

### Requirement: DocumentDB Document Operations

The DocumentDB provider SHALL implement in-memory document insert, find, update, and delete operations via the cluster_db_service, scoped per cluster and collection.

#### Scenario: Document inserted and retrieved

- **GIVEN** a DocumentDB cluster exists
- **WHEN** a document is inserted into a collection
- **THEN** a find query on that collection returns the document

### Requirement: ElastiCache and MemoryDB Redis Commands

The ElastiCache and MemoryDB providers SHALL implement core Redis commands (GET, SET, DEL, EXPIRE, LPUSH, LRANGE, HSET, HGET, SADD, SMEMBERS) via the cluster_db_service, using an in-memory key-value store scoped per cluster.

#### Scenario: SET and GET round-trip

- **GIVEN** an ElastiCache cluster exists
- **WHEN** SET is called with a key and value
- **THEN** GET for that key returns the value

#### Scenario: Key expires after TTL

- **GIVEN** a key is set with EXPIRE
- **WHEN** the TTL elapses
- **THEN** GET returns nil

### Requirement: Elasticsearch and OpenSearch Document Operations

The Elasticsearch and OpenSearch providers SHALL implement document index, search, and delete operations, and index create/delete, via the cluster_db_service using an in-memory document store per index.

#### Scenario: Document indexed and searchable

- **GIVEN** an Elasticsearch domain exists
- **WHEN** a document is indexed
- **THEN** a search query matching the document returns it in results

#### Scenario: Deleted document not returned in search

- **GIVEN** a document exists in an index
- **WHEN** the document is deleted
- **THEN** subsequent searches do not return it
