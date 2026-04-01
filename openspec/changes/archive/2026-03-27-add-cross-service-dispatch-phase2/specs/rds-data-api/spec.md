## ADDED Requirements

### Requirement: RDS Data API Execute Statement
The system SHALL implement the RDS Data API `ExecuteStatement` endpoint (`POST /execute`) that executes SQL against a per-cluster SQLite backend and returns results in the RDS Data API response format.

#### Scenario: SELECT statement returns rows
- **GIVEN** an RDS cluster exists and a table has been created via DDL
- **WHEN** `execute_statement` is called with a SELECT SQL query
- **THEN** the response contains a `records` array with one entry per row, each entry being an array of typed value objects

#### Scenario: INSERT statement succeeds
- **GIVEN** an RDS cluster exists and a table exists
- **WHEN** `execute_statement` is called with an INSERT SQL statement
- **THEN** the response indicates the number of records updated

#### Scenario: DDL statement creates a table
- **GIVEN** an RDS cluster exists
- **WHEN** `execute_statement` is called with a `CREATE TABLE` DDL statement
- **THEN** the table is created and subsequent DML against that table succeeds

#### Scenario: SQL syntax error returns error response
- **GIVEN** an RDS cluster exists
- **WHEN** `execute_statement` is called with invalid SQL
- **THEN** an error response is returned describing the SQL syntax error

#### Scenario: Unknown cluster returns error
- **GIVEN** no RDS cluster exists with the specified ARN
- **WHEN** `execute_statement` is called with that cluster ARN
- **THEN** a `BadRequestException` is returned

### Requirement: RDS Data API SQL Response Format
The system SHALL return SQL query results in the standard RDS Data API response envelope format, including typed column values.

#### Scenario: String values use stringValue wrapper
- **GIVEN** a SELECT query returns a VARCHAR column
- **WHEN** the response is returned
- **THEN** each string cell is encoded as `{"stringValue": "..."}` in the records array

#### Scenario: Numeric values use longValue or doubleValue wrapper
- **GIVEN** a SELECT query returns an INTEGER or FLOAT column
- **WHEN** the response is returned
- **THEN** integer cells are encoded as `{"longValue": N}` and float cells as `{"doubleValue": N}`

### Requirement: RDS Data API Database Lifecycle
The system SHALL create a dedicated SQLite database for each RDS cluster and maintain it for the lifetime of the cluster within the session.

#### Scenario: Database initialised on cluster creation
- **GIVEN** `create_db_cluster` is called
- **WHEN** the cluster is in AVAILABLE status
- **THEN** a SQLite database is available for use via the Data API

#### Scenario: Database is isolated per cluster
- **GIVEN** two RDS clusters exist
- **WHEN** DDL is executed against one cluster
- **THEN** the schema change is not visible through the other cluster's Data API endpoint
