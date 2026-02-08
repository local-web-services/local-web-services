## ADDED Requirements

### Requirement: Configuration File
LDK SHALL support an optional `ldk.config.py` configuration file in the project root that allows developers to customize local environment behavior. LDK SHALL use sensible defaults derived from the CDK definition when no configuration file is present.

#### Scenario: No configuration file uses defaults
- **WHEN** a developer runs `ldk dev` without an `ldk.config.py` file
- **THEN** LDK SHALL start with default settings (auto-assigned port, persistence enabled, default providers)

#### Scenario: Custom configuration applied
- **WHEN** a developer provides an `ldk.config.py` with `port = 3000` and `log_level = "debug"`
- **THEN** the local HTTP server SHALL listen on port 3000 and logging SHALL be set to debug level

### Requirement: Port Configuration
The configuration SHALL allow specifying the base port for HTTP endpoints.

#### Scenario: Custom port
- **WHEN** the configuration sets `port = 8080`
- **THEN** the API Gateway provider SHALL listen on port 8080

### Requirement: State Persistence Configuration
The configuration SHALL allow enabling or disabling state persistence between sessions and specifying the data directory.

#### Scenario: Disable persistence
- **WHEN** the configuration sets `persist = False`
- **THEN** all local state SHALL be discarded when `ldk dev` is stopped

#### Scenario: Custom data directory
- **WHEN** the configuration sets `data_dir = ".ldk-data"`
- **THEN** SQLite databases and filesystem storage SHALL be stored in the `.ldk-data` directory

### Requirement: Provider Selection
The configuration SHALL allow selecting alternative provider implementations for each service type.

#### Scenario: Swap DynamoDB provider
- **WHEN** the configuration sets `providers = {"dynamodb": "dynamodb-local"}`
- **THEN** LDK SHALL use the DynamoDB Local container instead of the SQLite-based provider

### Requirement: Resource Overrides
The configuration SHALL allow overriding specific resources to point at external service endpoints.

#### Scenario: Override specific resource endpoint
- **WHEN** the configuration overrides `MyStack/CacheTable` with `endpoint = "http://localhost:8000"`
- **THEN** SDK calls for that table SHALL be routed to the external endpoint instead of the local provider

### Requirement: Hybrid Mode
The configuration SHALL support hybrid mode where individual resources can be pointed at real AWS endpoints while the rest of the application runs locally.

#### Scenario: Use real Cognito with local everything else
- **WHEN** the configuration overrides `MyStack/UserPool` with `use_aws = True`
- **THEN** Cognito operations SHALL be routed to the real AWS service while all other resources use local providers

### Requirement: Watch Path Configuration
The configuration SHALL allow specifying include and exclude patterns for the file watcher.

#### Scenario: Custom watch paths
- **WHEN** the configuration sets `watch = {"include": ["src/**"], "exclude": ["**/*.test.*"]}`
- **THEN** the file watcher SHALL only monitor files matching the include patterns and ignore files matching the exclude patterns

### Requirement: Eventual Consistency Delay Configuration
The configuration SHALL allow setting the eventual consistency simulation delay for providers that support it. The default delay SHALL be 200 milliseconds.

#### Scenario: Custom eventual consistency delay
- **WHEN** the configuration sets `eventual_consistency_delay_ms = 500`
- **THEN** eventually consistent reads SHALL use a 500ms delay instead of the 200ms default

#### Scenario: Default delay applied
- **WHEN** no eventual consistency delay is configured
- **THEN** the default delay of 200 milliseconds SHALL be used

### Requirement: Validation Strictness Configuration
The configuration SHALL allow setting the validation engine strictness level (warn or strict).

#### Scenario: Enable strict validation
- **WHEN** the configuration sets `validation = "strict"`
- **THEN** validation errors SHALL block handler execution instead of only logging warnings
