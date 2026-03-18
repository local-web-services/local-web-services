---
name: "LWS: IAM Auth"
description: Configure IAM authorization to test that your application's IAM permissions are correct locally.
---

You are helping the user set up IAM authorization using local-web-services (lws).
IAM auth evaluates identity policies, boundary policies, and resource policies against each request before it reaches the service handler.

**Before you start, check the current state:**
1. Run `lws status` to confirm ldk is running
2. Run `lws iam-auth status` to see current configuration

**Modes:**
- `enforce` — requests that fail the IAM check are denied (HTTP 403)
- `audit` — requests pass through but violations are logged as warnings
- `disabled` — IAM auth is bypassed entirely (default)

**Runtime commands (require ldk dev running):**
```bash
# Show current IAM auth config
lws iam-auth status

# Enable enforce mode for a service
lws iam-auth enable <service>

# Enable audit mode for a service
lws iam-auth set <service> --mode audit

# Disable IAM auth for a service
lws iam-auth disable <service>

# Switch the active identity
lws iam-auth set-identity <identity-name>
```

**Supported services:** dynamodb, sqs, s3, sns, events, stepfunctions, cognito-idp, ssm, secretsmanager

**Config file (ldk.yaml):**
```yaml
iam_auth:
  mode: enforce             # global default: enforce | audit | disabled
  default_identity: admin-user
  identity_header: X-Lws-Identity   # optional per-request override header
  services:
    dynamodb:
      mode: enforce
    s3:
      mode: audit
```

**Identity definitions (.lws/iam/identities.yaml):**
```yaml
identities:
  admin-user:
    inline_policies:
      - name: admin
        document:
          Version: "2012-10-17"
          Statement:
            - Effect: Allow
              Action: "*"
              Resource: "*"

  readonly-role:
    inline_policies:
      - name: read-only
        document:
          Version: "2012-10-17"
          Statement:
            - Effect: Allow
              Action: ["dynamodb:GetItem", "s3:GetObject"]
              Resource: "*"
    boundary_policy:
      Version: "2012-10-17"
      Statement:
        - Effect: Allow
          Action: ["dynamodb:GetItem", "s3:GetObject"]
          Resource: "*"
```

**Permissions map (.lws/iam/permissions.yaml):**
Override or extend the built-in operation-to-action mappings:
```yaml
permissions:
  dynamodb:
    get-item:
      actions: ["dynamodb:GetItem"]
  s3:
    get-object:
      actions: ["s3:GetObject"]
```

**Resource policies (.lws/iam/resource_policies.yaml):**
```yaml
resource_policies:
  s3:
    my-public-bucket:
      Version: "2012-10-17"
      Statement:
        - Effect: Allow
          Principal: "*"
          Action: "s3:GetObject"
          Resource: "arn:aws:s3:::my-public-bucket/*"
```

**Policy evaluation order (matches AWS):**
1. Explicit Deny in any policy → DENY
2. Resource policy Allow → ALLOW
3. Boundary policy check → DENY if action not permitted
4. Identity policy Allow → ALLOW
5. Implicit DENY

**Per-request identity override:**
Send `X-Lws-Identity: <identity-name>` in the request header to use a specific identity for that request (useful for testing from code without changing the global default).

**Steps:**
1. Ask the user which service(s) they want to test and what mode (enforce/audit)
2. Help them define the relevant identities in `.lws/iam/identities.yaml`
3. Run `lws iam-auth enable <service>` or set the config in `ldk.yaml`
4. Run their application or use `lws` commands to trigger the operations
5. Verify results with `lws iam-auth status` and check logs for audit warnings
