---
name: "LWS: Chaos"
description: Enable chaos engineering to inject errors, latency, and timeouts into AWS service calls.
---

You are helping the user configure chaos engineering using local-web-services (lws).
Chaos injection adds random failures to AWS service calls to test application resilience.

**Before you start, check the current state:**
1. Run `lws status` to confirm ldk is running
2. Run `lws chaos status` to see current chaos configuration for all services

**Supported services:** dynamodb, sqs, s3, sns, events, stepfunctions, cognito-idp, ssm, secretsmanager

**Commands:**

```bash
# Enable chaos for a service
lws chaos enable <service>

# Disable chaos for a service
lws chaos disable <service>

# Check chaos status for all services
lws chaos status

# Configure chaos parameters
lws chaos set <service> [options]
```

**Chaos parameters (all are probabilities 0.0-1.0 or milliseconds):**
- `--error-rate <float>` — Probability of returning a 500 error (0.0 to 1.0)
- `--latency-min <ms>` — Minimum added latency in milliseconds
- `--latency-max <ms>` — Maximum added latency in milliseconds
- `--timeout-rate <float>` — Probability of a request timeout (0.0 to 1.0)
- `--connection-reset-rate <float>` — Probability of a connection reset (0.0 to 1.0)

**Common scenarios:**

1. **Test error handling** — 50% of DynamoDB calls fail:
   ```bash
   lws chaos enable dynamodb
   lws chaos set dynamodb --error-rate 0.5
   ```

2. **Test latency tolerance** — S3 calls take 200-500ms extra:
   ```bash
   lws chaos enable s3
   lws chaos set s3 --latency-min 200 --latency-max 500
   ```

3. **Test timeout handling** — 30% of SQS calls timeout:
   ```bash
   lws chaos enable sqs
   lws chaos set sqs --timeout-rate 0.3
   ```

4. **Test connection resilience** — 20% of SNS calls reset:
   ```bash
   lws chaos enable sns
   lws chaos set sns --connection-reset-rate 0.2
   ```

5. **Combined chaos** — Multiple failure modes:
   ```bash
   lws chaos enable dynamodb
   lws chaos set dynamodb --error-rate 0.3 --latency-min 100 --latency-max 300 --timeout-rate 0.1
   ```

**Steps:**
1. Ask the user which service(s) they want to add chaos to
2. Ask what kind of failures they want to simulate (errors, latency, timeouts, connection resets)
3. Help them choose appropriate rates (start low, increase as needed)
4. Run the commands and verify with `lws chaos status`
5. Remind them to disable chaos when done: `lws chaos disable <service>`
