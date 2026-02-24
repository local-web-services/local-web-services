---
name: "LWS: Mock"
description: Create or configure AWS operation mocks to return canned responses.
---

You are helping the user set up AWS operation mocks using local-web-services (lws).
AWS operation mocks intercept specific AWS API calls and return canned responses instead of hitting the real local provider.

**Before you start, check the current state:**
1. Run `lws status` to confirm ldk is running
2. Run `lws aws-mock status` to see existing mock rules

**Supported services:** dynamodb, sqs, s3, sns, events, stepfunctions, cognito-idp, ssm, secretsmanager

**Two approaches:**

**File-based mocks** (persist across restarts, stored in `.lws/mocks/`):
```bash
# Create a mock definition
lws aws-mock create <name> --service <service>

# Add an operation rule
lws aws-mock add-operation <name> --operation <operation> --status 200 --body '<response>'

# List existing mocks
lws aws-mock list

# Remove an operation
lws aws-mock remove-operation <name> --operation <operation>

# Delete a mock entirely
lws aws-mock delete <name> --yes
```

**Runtime mocks** (configure on the fly, lost on restart):
```bash
lws aws-mock set-rules <service> --operation <operation> --status 200 --body '<response>'
lws aws-mock enable <service>
lws aws-mock disable <service>
```

**Wire protocol notes:**
- SQS, SNS, S3 use XML responses — mock bodies must be valid XML
- DynamoDB, Step Functions, EventBridge, Cognito, SSM, Secrets Manager use JSON responses
- Operation names use CLI-style kebab-case: `get-item`, `list-tables`, `get-object`

**Helper flags for add-operation:**
- S3: `--body-string "content"` or `--body-file ./path`
- DynamoDB: `--item '{"id": "123", "name": "Alice"}'` (auto-wraps to DynamoDB JSON)
- SSM: `--param-name /app/key --param-value myvalue`
- Secrets Manager: `--secret-string '{"user":"admin"}' --secret-name my-secret`

**Header filtering** (mock only activates when header is present):
```bash
lws aws-mock add-operation <name> --operation get-object --body '...' --match-header x-test=special
```

**Steps:**
1. Ask the user which service and operation they want to mock
2. Determine whether they want file-based (persistent) or runtime mocks
3. Help construct the appropriate response body for their service's wire protocol
4. Run the commands and verify with `lws aws-mock status`
