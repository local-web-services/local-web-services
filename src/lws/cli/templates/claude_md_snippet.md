# Local Web Services (LWS)

This project uses [local-web-services](https://github.com/local-web-services/local-web-services) to run AWS services locally during development.

## Quick Reference

### Starting the local environment
```bash
ldk dev
```

### Checking status
```bash
lws status
```

### Available slash commands
- `/lws:mock` — Create or configure AWS operation mocks (return canned responses for specific operations)
- `/lws:chaos` — Enable chaos engineering (inject errors, latency, timeouts into AWS service calls)

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
