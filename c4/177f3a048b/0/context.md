# Session Context

**Session ID:** f80e9f50-ba6f-47c5-8c68-9b762f3e1732

**Commit Message:** Implement the following plan:

# Plan: Add missing CLI commands for exis

## Prompt

Implement the following plan:

# Plan: Add missing CLI commands for existing provider operations

## Context

The provider layer already implements many operations that the CLI doesn't expose. These are the biggest serverless gaps — 25 operations across S3, DynamoDB, and Lambda where the backend works but there's no CLI command or E2E test. Adding these completes Terraform/CDK compatibility and covers common serverless workflows (S3 copy, batch delete, bucket config, Lambda tags/permissions, DynamoDB TTL/tags).

## Scope

25 new CLI commands + 25 feature files + step definitions across 3 services. No provider changes needed — all operations already have handlers.

---

## S3 — 11 new commands

**File to modify:** `src/lws/cli/services/s3.py`
**Pattern:** `rest_request` returning `httpx.Response`, parse XML with `xml_to_dict`

| # | Command | Parameters | Wire Protocol |
|---|---------|-----------|---------------|
| 1 | `copy-object` | `--bucket`, `--key`, `--copy-source` | PUT /{bucket}/{key} + header x-amz-copy-source |
| 2 | `delete-objects` | `--bucket`, `--delete` (JSON) | POST /{bucket}?delete + XML body |
| 3 | `put-bucket-tagging` | `--bucket`, `--tagging` (JSON) | PUT /{bucket}?tagging + XML body |
| 4 | `get-bucket-tagging` | `--bucket` | GET /{bucket}?tagging |
| 5 | `delete-bucket-tagging` | `--bucket` | DELETE /{bucket}?tagging |
| 6 | `get-bucket-location` | `--bucket` | GET /{bucket}?location |
| 7 | `put-bucket-policy` | `--bucket`, `--policy` (JSON string) | PUT /{bucket}?policy + JSON body |
| 8 | `get-bucket-policy` | `--bucket` | GET /{bucket}?policy |
| 9 | `put-bucket-notification-configuration` | `--bucket`, `--notification-configuration` (JSON) | PUT /{bucket}?notification + XML body |
| 10 | `get-bucket-notification-configuration` | `--bucket` | GET /{bucket}?notification |
| 11 | `list-parts` | `--bucket`, `--key`, `--upload-id` | GET /{bucket}/{key}?uploadId=xxx |

**Notes:**
- `delete-objects` takes JSON `{"Objects": [{"Key": "k1"}, {"Key": "k2"}]}`, must convert to XML `<Delete><Object><Key>k1</Key></Object>...</Delete>`
- `put-bucket-tagging` takes JSON `{"TagSet": [{"Key":"k","Value":"v"}]}`, must convert to XML
- `put-bucket-notification-configuration` takes JSON, must convert to XML
- `copy-object` sets header `x-amz-copy-source: /{source-bucket}/{source-key}`
- `get-bucket-policy` returns raw JSON (the policy), not XML
- GET operations parse XML response with `xml_to_dict`

**E2E feature files** (in `tests/e2e/s3api/features/`):
- `copy_object.feature` — copy object between keys, verify content matches
- `delete_objects.feature` — batch delete, verify objects removed
- `put_bucket_tagging.feature` — set tags, verify with get
- `get_bucket_tagging.feature` — get tags after setting
- `delete_bucket_tagging.feature` — remove tags, verify empty
- `get_bucket_location.feature` — returns us-east-1
- `put_bucket_policy.feature` — set policy, verify with get
- `get_bucket_policy.feature` — get policy after setting
- `put_bucket_notification_configuration.feature` — set config, verify with get
- `get_bucket_notification_configuration.feature` — get config after setting
- `list_parts.feature` — list parts of in-progress multipart upload

**Step definitions** to add to `tests/e2e/s3api/conftest.py`:
- Given: `tags were set on bucket`, `a policy was set on bucket`, `a notification config was set on bucket`
- When: one per command (e.g., `i_copy_object`, `i_delete_objects`, etc.)
- Then: `bucket_will_have_tags`, `bucket_will_have_policy`, `the_output_will_contain_location`, etc.

---

## DynamoDB — 7 new commands

**File to modify:** `src/lws/cli/services/dynamodb.py`
**Pattern:** `json_target_request` with `DynamoDB_20120810.{Operation}`

| # | Command | Parameters | Target |
|---|---------|-----------|--------|
| 1 | `update-table` | `--table-name`, `--billing-mode` (opt) | DynamoDB_20120810.UpdateTable |
| 2 | `describe-time-to-live` | `--table-name` | DynamoDB_20120810.DescribeTimeToLive |
| 3 | `update-time-to-live` | `--table-name`, `--time-to-live-specification` (JSON) | DynamoDB_20120810.UpdateTimeToLive |
| 4 | `describe-continuous-backups` | `--table-name` | DynamoDB_20120810.DescribeContinuousBackups |
| 5 | `tag-resource` | `--resource-arn`, `--tags` (JSON) | DynamoDB_20120810.TagResource |
| 6 | `untag-resource` | `--resource-arn`, `--tag-keys` (JSON) | DynamoDB_20120810.UntagResource |
| 7 | `list-tags-of-resource` | `--resource-arn` | DynamoDB_20120810.ListTagsOfResource |

**Notes:**
- All stubs return safe default data (table description, DISABLED status, empty tags)
- `update-table` body: `{"TableName": name, "BillingMode": mode}` (optional fields)
- `update-time-to-live` body: `{"TableName": name, "TimeToLiveSpecification": {...}}`
- Tag operations use `--resource-arn` (ARN format: `arn:aws:dynamodb:us-east-1:000000000000:table/{name}`)

**E2E feature files** (in `tests/e2e/dynamodb/features/`):
- `update_table.feature` — update billing mode, verify table still exists
- `describe_time_to_live.feature` — check default TTL status
- `update_time_to_live.feature` — enable TTL, verify response
- `describe_continuous_backups.feature` — check backups status
- `tag_resource.feature` — tag table
- `untag_resource.feature` — untag table
- `list_tags_of_resource.feature` — list tags

**Step definitions** to add to `tests/e2e/dynamodb/conftest.py`:
- When: one per command
- Then: verify output contains expected fields

---

## Lambda — 7 new commands

**File to modify:** `src/lws/cli/services/lambda_service.py`
**Pattern:** `rest_request` with Lambda REST API paths

| # | Command | Parameters | Wire Protocol |
|---|---------|-----------|---------------|
| 1 | `tag-resource` | `--resource` (ARN), `--tags` (JSON dict) | POST /2015-03-31/tags/{arn} |
| 2 | `untag-resource` | `--resource` (ARN), `--tag-keys` (JSON array) | DELETE /2015-03-31/tags/{arn}?tagKeys=k1&tagKeys=k2 |
| 3 | `list-tags` | `--resource` (ARN) | GET /2015-03-31/tags/{arn} |
| 4 | `add-permission` | `--function-name`, `--statement-id`, `--action`, `--principal` | POST /2015-03-31/functions/{name}/policy |
| 5 | `remove-permission` | `--function-name`, `--statement-id` | DELETE /2015-03-31/functions/{name}/policy/{sid} |
| 6 | `get-policy` | `--function-name` | GET /2015-03-31/functions/{name}/policy |
| 7 | `get-event-source-mapping` | `--uuid` | GET /2015-03-31/event-source-mappings/{uuid} |

**Notes:**
- Tags are REAL implementations (stored in memory)
- Permissions are stubs (add returns canned Statement, get returns empty Policy)
- Lambda uses `port + 9` for the runtime port (see existing `invoke` command)
- Tag operations need URL-encoded ARN in path
- `untag-resource` sends tag keys as repeated query params

**Skipped:** `list-versions-by-function` (returns only $LATEST) and `get-code-signing-config` (not relevant for local dev)

**E2E feature files** (in `tests/e2e/lambda_/features/`):
- `tag_resource.feature` — tag function, verify with list-tags
- `untag_resource.feature` — untag, verify removed
- `list_tags.feature` — list after tagging
- `add_permission.feature` — add permission, verify response
- `remove_permission.feature` — remove permission
- `get_policy.feature` — get function policy
- `get_event_source_mapping.feature` — get ESM by UUID

**Step definitions** to add to `tests/e2e/lambda_/conftest.py`:
- Given: `function was tagged with tags` (setup)
- When: one per command
- Then: `the_tags_will_include`, `the_output_will_contain_statement`, etc.

---

## Files to modify

### CLI (3 files)
- `src/lws/cli/services/s3.py` — add 11 commands
- `src/lws/cli/services/dynamodb.py` — add 7 commands
- `src/lws/cli/services/lambda_service.py` — add 7 commands

### E2E tests — feature files (25 new files)
- `tests/e2e/s3api/features/` — 11 new .feature files
- `tests/e2e/dynamodb/features/` — 7 new .feature files
- `tests/e2e/lambda_/features/` — 7 new .feature files

### E2E tests — step definitions (3 files)
- `tests/e2e/s3api/conftest.py` — add ~20 step definitions
- `tests/e2e/dynamodb/conftest.py` — add ~14 step definitions
- `tests/e2e/lambda_/conftest.py` — add ~14 step definitions

---

## Verification

```bash
make lint           # ruff + format check
make check          # all unit + integration tests still pass
make test-e2e       # 226 existing + ~50 new scenarios pass
```


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

## Summary

All done. Here's a summary of what was implemented:

## Summary

### CLI Commands (25 total)

**S3 — 11 new commands** in `src/lws/cli/services/s3.py`:
- `copy-object`, `delete-objects`, `put-bucket-tagging`, `get-bucket-tagging`, `delete-bucket-tagging`, `get-bucket-location`, `put-bucket-policy`, `get-bucket-policy`, `put-bucket-notification-configuration`, `get-bucket-notification-configuration`, `list-parts`

**DynamoDB — 7 new commands** in `src/lws/cli/services/dynamodb.py`:
- `update-table`, `describe-time-to-live`, `update-time-to-live`, `describe-continuous-backups`, `tag-resource`, `untag-resource`, `list-tags-of-resource`

**Lambda — 7 new commands** in `src/lws/cli/services/lambda_service.py`:
- `tag-resource`, `untag-resource`, `list-tags`, `add-permission`, `remove-permission`, `get-policy`, `get-event-source-mapping`

### E2E Tests (25 feature files + step definitions)
- 11 feature files in `tests/e2e/s3api/features/` with step definitions in `conftest.py`
- 7 feature files in `tests/e2e/dynamodb/features/` with step definitions in `conftest.py`
- 7 feature files in `tests/e2e/lambda_/features/` with step definitions in `conftest.py`

### Verification
- `make lint` — passes (ruff clean)
- `make check` — passes (all 2240 unit/integration tests pass, pylint 10/10, black formatted)

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/s3.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/dynamodb.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/lambda_service.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/s3api/conftest.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/dynamodb/conftest.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/lambda_/conftest.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/client.py
- - **Glob**: tests/e2e/s3api/features/*.feature
- - **Glob**: tests/e2e/dynamodb/features/*.feature
- - **Glob**: tests/e2e/lambda_/features/*.feature
