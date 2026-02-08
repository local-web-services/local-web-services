## ADDED Requirements

### Requirement: Graph Construction
The application graph engine SHALL construct a directed graph from the parsed cloud assembly where nodes represent compute and storage resources and edges represent event flows and data dependencies.

#### Scenario: Build graph from parsed resources
- **WHEN** the parser outputs a normalized set of resources and their relationships
- **THEN** the graph engine SHALL create nodes for each resource and directed edges for trigger relationships, data dependencies, and permission boundaries

### Requirement: Trigger Relationship Mapping
The graph engine SHALL identify and record trigger relationships between resources, including HTTP request triggers, queue message triggers, scheduled event triggers, stream record triggers, and S3 event notification triggers.

#### Scenario: Map API Gateway to Lambda trigger
- **WHEN** the cloud assembly defines an API Gateway REST API with a route mapped to a Lambda function
- **THEN** the graph SHALL contain a trigger edge from the API Gateway route node to the Lambda function node

### Requirement: Data Dependency Mapping
The graph engine SHALL identify and record data dependencies between functions and stateful resources (tables, buckets, queues).

#### Scenario: Map Lambda to DynamoDB dependency
- **WHEN** a Lambda function has an environment variable referencing a DynamoDB table and IAM permissions to access it
- **THEN** the graph SHALL contain a data dependency edge from the function to the table

### Requirement: Permission Boundary Extraction
The graph engine SHALL extract permission boundaries from IAM policy statements derived from CDK grant methods, recording which functions are granted access to which resources.

#### Scenario: Extract grantRead permission
- **WHEN** the CDK code uses `table.grantReadData(handler)` which produces IAM policy statements in the CloudFormation template
- **THEN** the graph SHALL record that the handler has read permission on the table

### Requirement: Dependency-Ordered Startup
The graph engine SHALL compute a startup sequence for local services based on the dependency graph, ensuring that stateful resources (tables, queues, buckets) are started before the compute resources that depend on them.

#### Scenario: Start table before handler
- **WHEN** the application graph contains a Lambda function that depends on a DynamoDB table
- **THEN** the local DynamoDB table SHALL be initialized before the Lambda function is made available for invocation
