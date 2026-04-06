# dynamodb-gsi-query Specification

## Purpose
TBD - created by archiving change add-dynamodb-gsi-query. Update Purpose after archive.
## Requirements
### Requirement: DynamoDB GSI Table Creation
The system SHALL accept a `CreateTable` request containing a `GlobalSecondaryIndexes` definition and SHALL create the corresponding SQLite GSI projection table so that subsequent `Query` calls using `IndexName` can be served.

#### Scenario: Table with GSI created successfully
- **GIVEN** no table named "Orders" exists
- **WHEN** `CreateTable` is called with a `GlobalSecondaryIndexes` entry defining partition key `status` and sort key `createdAt`
- **THEN** the response contains `TableDescription.GlobalSecondaryIndexes` listing the index with `IndexStatus: ACTIVE`

#### Scenario: DescribeTable returns GSI metadata
- **GIVEN** an "Orders" table was created with a GSI named `byStatus`
- **WHEN** `DescribeTable` is called for "Orders"
- **THEN** the response `Table.GlobalSecondaryIndexes` contains an entry with `IndexName: byStatus` and `IndexStatus: ACTIVE`

### Requirement: DynamoDB GSI Query
The system SHALL execute a `Query` request that includes an `IndexName` parameter by looking up items in the matching GSI projection table and SHALL return only those items whose GSI partition key matches the supplied `KeyConditionExpression`.

#### Scenario: Query via GSI returns matching items
- **GIVEN** an "Orders" table with a GSI `byStatus` (partition key `status`) exists
- **AND** three items exist: two with `status = "shipped"` and one with `status = "pending"`
- **WHEN** `Query` is called with `IndexName: byStatus` and `KeyConditionExpression: status = :s` (`:s = "shipped"`)
- **THEN** the response `Items` contains exactly the two `"shipped"` items and `Count` is 2

#### Scenario: Query via GSI with sort key range condition
- **GIVEN** an "Orders" table with a GSI `byStatus` (partition key `status`, sort key `createdAt`) exists
- **AND** two items exist with `status = "shipped"` and `createdAt` values `"2024-01-01"` and `"2024-01-02"`
- **WHEN** `Query` is called with `IndexName: byStatus`, `KeyConditionExpression: status = :s AND createdAt >= :d`
- **THEN** only items satisfying the sort key condition are returned

#### Scenario: Query via GSI excludes items lacking the GSI key attribute (sparse index)
- **GIVEN** an "Orders" table with a GSI `byStatus` (partition key `status`) exists
- **AND** one item has `status = "shipped"` and another item has no `status` attribute
- **WHEN** `Query` is called with `IndexName: byStatus` and `KeyConditionExpression: status = :s`
- **THEN** only the item with `status = "shipped"` is returned; the item without `status` is not included

### Requirement: DynamoDB GSI Consistency After Mutations
The system SHALL keep the GSI projection table consistent with the base table: when an item is written the GSI entry SHALL be created or replaced, and when an item is deleted the GSI entry SHALL be removed.

#### Scenario: PutItem updates the GSI projection
- **GIVEN** an "Orders" table with a GSI `byStatus` exists and an item with `status = "shipped"` is stored
- **WHEN** `PutItem` is called for the same primary key with `status = "delivered"`
- **AND** `Query` is called with `IndexName: byStatus` and `KeyConditionExpression: status = :s` (`:s = "delivered"`)
- **THEN** the updated item is returned by the GSI query

#### Scenario: DeleteItem removes the GSI projection
- **GIVEN** an "Orders" table with a GSI `byStatus` exists and one item with `status = "shipped"` is stored
- **WHEN** `DeleteItem` is called for that item
- **AND** `Query` is called with `IndexName: byStatus` and `KeyConditionExpression: status = :s` (`:s = "shipped"`)
- **THEN** zero items are returned

