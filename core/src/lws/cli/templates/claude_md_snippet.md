# Local Web Services (LWS)

This project uses [local-web-services](https://github.com/local-web-services/local-web-services) to run AWS services locally during development.

## Quick Reference

### Starting the local environment
```bash
# Foreground (logs to terminal)
ldk dev

# Background (detached process, logs to .lws/ldk-dev.log)
ldk dev --background
```

### Stopping a background instance
```bash
ldk stop --port <port>
```

### Checking status
```bash
lws status
```

### Available slash commands
- `/lws:mock` — Create or configure AWS operation mocks (return canned responses for specific operations)
- `/lws:chaos` — Enable chaos engineering (inject errors, latency, timeouts into AWS service calls)
- `/lws:iam-auth` — Configure IAM authorization (enforce/audit/disabled modes, identities, permissions)

### AWS Operation Mocking

Mock specific AWS operations to return canned responses during development:

```bash
# Create a mock definition
lws aws-mock create my-mock --service s3

# Add an operation rule
lws aws-mock add-operation my-mock --operation get-object --body '{"key": "value"}'

# Or configure at runtime (server must be running)
lws aws-mock set-rules s3 --operation get-object --status 200 --body '{"key": "value"}'

# Check mock status
lws aws-mock status
```

Supported services: dynamodb, sqs, s3, sns, events, stepfunctions, cognito-idp, ssm, secretsmanager.

### Chaos Engineering

Inject failures into AWS service calls for resilience testing:

```bash
# Enable chaos for a service
lws chaos enable dynamodb

# Configure error rates and latency
lws chaos set dynamodb --error-rate 0.5 --latency-min 100 --latency-max 500

# Check chaos status
lws chaos status

# Disable chaos
lws chaos disable dynamodb
```

Chaos parameters: `--error-rate`, `--latency-min`, `--latency-max`, `--timeout-rate`, `--connection-reset-rate`.

### IAM Authorization

Test IAM authorization locally to verify that your application's IAM permissions are correct:

```bash
# Check current IAM auth configuration
lws iam-auth status

# Enable enforce mode (denied requests return 403)
lws iam-auth enable dynamodb

# Enable audit mode (denied requests pass through but are logged)
lws iam-auth set dynamodb --mode audit

# Switch the active identity (e.g. to test a restricted role)
lws iam-auth set-identity readonly-role

# Disable IAM auth for a service
lws iam-auth disable dynamodb
```

Identities and permissions are configured in `.lws/iam/identities.yaml`, `.lws/iam/permissions.yaml`, and `.lws/iam/resource_policies.yaml`.

### Lambda Function URLs

Manage Lambda Function URL endpoints (each gets its own localhost port):

```bash
# Create a Function URL for a Lambda function
lws lambda create-function-url-config --function-name <name>

# Get Function URL config
lws lambda get-function-url-config --function-name <name>

# List all Function URLs
lws lambda list-function-url-configs

# Delete a Function URL
lws lambda delete-function-url-config --function-name <name>
```
