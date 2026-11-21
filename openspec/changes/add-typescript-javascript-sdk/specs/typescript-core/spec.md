## ADDED Requirements

### Requirement: TypeScript Core Server
The TypeScript core SHALL provide an in-process AWS service emulator server equivalent to the
Python core, exposing all 20 supported services on deterministic port offsets from a base port.

#### Scenario: Providers start in dependency order
- **WHEN** `ldk dev` is invoked
- **THEN** each provider starts on its assigned port offset
- **AND** providers with dependencies start only after their dependencies are healthy

#### Scenario: Management API available on base port
- **WHEN** the server is running
- **THEN** `GET /_ldk/resources` returns a JSON map of service names to port numbers
- **AND** `GET /_ldk/status` returns the health of each provider

#### Scenario: Graceful shutdown
- **WHEN** `POST /_ldk/shutdown` is called or SIGTERM is received
- **THEN** all providers flush state and stop in reverse dependency order

### Requirement: TypeScript Provider Lifecycle Interface
Every provider SHALL implement the `IProvider` interface with `start()`, `stop()`,
`healthCheck()`, and `flush()` methods.

#### Scenario: Health check after start
- **WHEN** a provider's `start()` resolves
- **THEN** `healthCheck()` returns `true` within 5 seconds

#### Scenario: Flush before stop
- **WHEN** `flush()` is called on a persistent provider (DynamoDB, Cognito)
- **THEN** in-memory state is written to its storage backend before `stop()` is called

### Requirement: TypeScript Fastify Middleware Chain
Each provider's Fastify app SHALL mount middleware in the following order (outermost first):
OperationFake → IamAuth → Chaos → RequestLogging → route handler.

#### Scenario: Request logging captures duration
- **WHEN** any AWS wire-protocol request is handled
- **THEN** the method, path, status code, and duration in milliseconds are logged

#### Scenario: Chaos middleware injects error
- **WHEN** chaos is enabled with an error rate of 100% for a service
- **THEN** every request to that service returns the configured error response

### Requirement: TypeScript DynamoDB Provider
The TypeScript DynamoDB provider SHALL implement the DynamoDB JSON target dispatch protocol
backed by SQLite (`better-sqlite3`), supporting the same operations as the Python provider.

#### Scenario: PutItem and GetItem round-trip
- **WHEN** a `DynamoDB_20120810.PutItem` request is sent with a valid item
- **THEN** a subsequent `DynamoDB_20120810.GetItem` returns the same item

#### Scenario: Scan returns all items
- **WHEN** multiple items exist in a table
- **THEN** `DynamoDB_20120810.Scan` returns all items

### Requirement: TypeScript SQS Provider
The TypeScript SQS provider SHALL implement the SQS JSON target dispatch protocol backed by
an in-memory queue, supporting the same operations as the Python provider.

#### Scenario: SendMessage and ReceiveMessage round-trip
- **WHEN** a message is sent to a queue
- **THEN** `ReceiveMessage` returns the message within the visibility timeout

### Requirement: TypeScript S3 Provider
The TypeScript S3 provider SHALL implement the S3 REST protocol backed by the local filesystem,
supporting the same operations as the Python provider.

#### Scenario: PutObject and GetObject round-trip
- **WHEN** an object is uploaded via `PUT /bucket/key`
- **THEN** a subsequent `GET /bucket/key` returns the same bytes

### Requirement: TypeScript SDK Environment Redirection
The TypeScript core SHALL set `AWS_ENDPOINT_URL_<SERVICE>` environment variables so that any
`@aws-sdk` client created in the same Node.js process automatically routes to local providers.

#### Scenario: SDK client routes to local provider
- **WHEN** `AWS_ENDPOINT_URL_DYNAMODB` is set to `http://localhost:<port>`
- **THEN** a `DynamoDBClient` created with default config sends requests to that port
