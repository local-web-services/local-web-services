---
name: "LWS: Fake"
description: Create or configure AWS operation fakes to return canned responses.
---

You are helping the user set up AWS operation fakes using local-web-services (lws).
AWS operation fakes intercept specific AWS API calls and return canned responses instead of hitting the real local provider.

**Before you start, check the current state:**
1. Run `lws status` to confirm ldk is running
2. Run `lws aws-fake status` to see existing fake rules

**Supported services:** dynamodb, sqs, s3, sns, events, stepfunctions, cognito-idp, ssm, secretsmanager

**Two approaches:**

**File-based fakes** (persist across restarts, stored in `.lws/fakes/`):
```bash
# Create a fake definition
lws aws-fake create <name> --service <service>

# Add an operation rule
lws aws-fake add-operation <name> --operation <operation> --status 200 --body '<response>'

# List existing fakes
lws aws-fake list

# Remove an operation
lws aws-fake remove-operation <name> --operation <operation>

# Delete a fake entirely
lws aws-fake delete <name> --yes
```

**Runtime fakes** (configure on the fly, lost on restart):
```bash
lws aws-fake set-rules <service> --operation <operation> --status 200 --body '<response>'
lws aws-fake enable <service>
lws aws-fake disable <service>
```

**Wire protocol notes:**
- SQS, SNS, S3 use XML responses — fake bodies must be valid XML
- DynamoDB, Step Functions, EventBridge, Cognito, SSM, Secrets Manager use JSON responses
- Operation names use CLI-style kebab-case: `get-item`, `list-tables`, `get-object`

**Helper flags for add-operation:**
- S3: `--body-string "content"` or `--body-file ./path`
- DynamoDB: `--item '{"id": "123", "name": "Alice"}'` (auto-wraps to DynamoDB JSON)
- SSM: `--param-name /app/key --param-value myvalue`
- Secrets Manager: `--secret-string '{"user":"admin"}' --secret-name my-secret`

**Header filtering** (fake only activates when header is present):
```bash
lws aws-fake add-operation <name> --operation get-object --body '...' --match-header x-test=special
```

**Steps:**
1. Ask the user which service and operation they want to fake
2. Determine whether they want file-based (persistent) or runtime fakes
3. Help construct the appropriate response body for their service's wire protocol
4. Run the commands and verify with `lws aws-fake status`
