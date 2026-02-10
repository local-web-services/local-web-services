## ADDED Requirements

### Requirement: Project Mode Configuration
The configuration SHALL support a `mode` setting that specifies the project type. Valid values SHALL be `"cdk"` and `"terraform"`. When not set, LWS SHALL auto-detect the project type from the working directory contents. The `--mode` CLI flag SHALL override the configuration value.

#### Scenario: Mode set in config
- **WHEN** `ldk.toml` contains `mode = "terraform"`
- **THEN** LWS SHALL start in Terraform mode without auto-detection

#### Scenario: CLI flag overrides config
- **WHEN** `ldk.toml` contains `mode = "cdk"` but the developer runs `ldk dev --mode terraform`
- **THEN** LWS SHALL start in Terraform mode
