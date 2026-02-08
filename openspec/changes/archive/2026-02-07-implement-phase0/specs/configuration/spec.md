## MODIFIED Requirements
### Requirement: Configuration File
LDK SHALL support an optional `ldk.config.py` configuration file in the project root that allows developers to customize local environment behavior. The configuration file SHALL be loaded via `importlib` (using `importlib.util.spec_from_file_location` and `module_from_spec`) and its module-level variables SHALL override defaults. The configuration SHALL be represented as an `LdkConfig` dataclass with fields: `port` (default: 3000), `persist` (default: True), `data_dir` (default: ".ldk"), `log_level` (default: "info"), `watch_include` (default: `["src/**", "lib/**", "lambda/**"]`), and `watch_exclude` (default: `["**/node_modules/**", "**/*.test.*", "**/cdk.out/**"]`). LDK SHALL use sensible defaults derived from the CDK definition when no configuration file is present.

#### Scenario: No configuration file uses defaults
- **WHEN** a developer runs `ldk dev` without an `ldk.config.py` file
- **THEN** LDK SHALL start with default settings (auto-assigned port, persistence enabled, default providers)

#### Scenario: Custom configuration applied
- **WHEN** a developer provides an `ldk.config.py` with `port = 3000` and `log_level = "debug"`
- **THEN** the local HTTP server SHALL listen on port 3000 and logging SHALL be set to debug level

#### Scenario: Configuration loaded via importlib
- **WHEN** an `ldk.config.py` file exists in the project root
- **THEN** it SHALL be loaded via `importlib.util.spec_from_file_location` and `module_from_spec`, and known module-level attribute names SHALL be mapped to `LdkConfig` dataclass fields
