"""Shared fixtures for IAM auth E2E tests."""

from __future__ import annotations

import json
import urllib.request

import pytest
from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

# ---------------------------------------------------------------------------
# Test identity definitions
# ---------------------------------------------------------------------------

_FULL_ACCESS_POLICY = {
    "Version": "2012-10-17",
    "Statement": [{"Effect": "Allow", "Action": "*", "Resource": "*"}],
}

# ---------------------------------------------------------------------------
# Minimal CLI args per service and operation (for IAM permission testing).
# The IAM middleware runs before the handler, so dummy values work fine
# for the denied/audit cases. For the pass case the handler may return a
# service error (e.g. ResourceNotFoundException) — that is OK because we
# only verify that IAM did NOT block the request.
# ---------------------------------------------------------------------------

_OPERATION_ARGS: dict[str, dict[str, list[str]]] = {
    "dynamodb": {
        "list-tables": [],
        "create-table": [
            "--table-name",
            "iam-test-table",
            "--key-schema",
            '[{"AttributeName":"pk","KeyType":"HASH"}]',
            "--attribute-definitions",
            '[{"AttributeName":"pk","AttributeType":"S"}]',
        ],
        "delete-table": ["--table-name", "iam-test-table"],
        "describe-table": ["--table-name", "iam-test-table"],
        "update-table": ["--table-name", "iam-test-table", "--billing-mode", "PAY_PER_REQUEST"],
        "describe-time-to-live": ["--table-name", "iam-test-table"],
        "update-time-to-live": [
            "--table-name",
            "iam-test-table",
            "--time-to-live-specification",
            '{"Enabled":true,"AttributeName":"ttl"}',
        ],
        "describe-continuous-backups": ["--table-name", "iam-test-table"],
        "get-item": ["--table-name", "iam-test-table", "--key", '{"pk":{"S":"x"}}'],
        "put-item": ["--table-name", "iam-test-table", "--item", '{"pk":{"S":"x"}}'],
        "delete-item": ["--table-name", "iam-test-table", "--key", '{"pk":{"S":"x"}}'],
        "update-item": [
            "--table-name",
            "iam-test-table",
            "--key",
            '{"pk":{"S":"x"}}',
            "--update-expression",
            "SET #n = :v",
        ],
        "query": [
            "--table-name",
            "iam-test-table",
            "--key-condition-expression",
            "pk = :pk",
            "--expression-attribute-values",
            '{":pk":{"S":"x"}}',
        ],
        "scan": ["--table-name", "iam-test-table"],
        "batch-get-item": [
            "--request-items",
            '{"iam-test-table":{"Keys":[{"pk":{"S":"x"}}]}}',
        ],
        "batch-write-item": [
            "--request-items",
            '{"iam-test-table":{"PutRequests":[{"PutRequest":{"Item":{"pk":{"S":"x"}}}}]}}',
        ],
        "transact-get-items": [
            "--transact-items",
            '[{"Get":{"TableName":"iam-test-table","Key":{"pk":{"S":"x"}}}}]',
        ],
        "transact-write-items": [
            "--transact-items",
            '[{"Put":{"TableName":"iam-test-table","Item":{"pk":{"S":"x"}}}}]',
        ],
        "list-tags-of-resource": [
            "--resource-arn",
            "arn:aws:dynamodb:us-east-1:000000000000:table/iam-test-table",
        ],
        "tag-resource": [
            "--resource-arn",
            "arn:aws:dynamodb:us-east-1:000000000000:table/iam-test-table",
            "--tags",
            '[{"Key":"k","Value":"v"}]',
        ],
        "untag-resource": [
            "--resource-arn",
            "arn:aws:dynamodb:us-east-1:000000000000:table/iam-test-table",
            "--tag-keys",
            '["k"]',
        ],
    },
    "sqs": {
        "list-queues": [],
        "create-queue": ["--queue-name", "iam-test-queue"],
        "delete-queue": ["--queue-name", "iam-test-queue"],
        "get-queue-url": ["--queue-name", "iam-test-queue"],
        "get-queue-attributes": ["--queue-name", "iam-test-queue"],
        "set-queue-attributes": [
            "--queue-name",
            "iam-test-queue",
            "--attributes",
            '{"VisibilityTimeout":"30"}',
        ],
        "purge-queue": ["--queue-name", "iam-test-queue"],
        "list-queue-tags": ["--queue-name", "iam-test-queue"],
        "tag-queue": ["--queue-name", "iam-test-queue", "--tags", '{"k":"v"}'],
        "untag-queue": ["--queue-name", "iam-test-queue", "--tag-keys", '["k"]'],
        "send-message": ["--queue-name", "iam-test-queue", "--message-body", "test"],
        "send-message-batch": [
            "--queue-name",
            "iam-test-queue",
            "--entries",
            '[{"Id":"1","MessageBody":"test"}]',
        ],
        "receive-message": ["--queue-name", "iam-test-queue"],
        "delete-message": [
            "--queue-name",
            "iam-test-queue",
            "--receipt-handle",
            "test-receipt-handle",
        ],
        "delete-message-batch": [
            "--queue-name",
            "iam-test-queue",
            "--entries",
            '[{"Id":"1","ReceiptHandle":"test-receipt-handle"}]',
        ],
        "change-message-visibility": [
            "--queue-name",
            "iam-test-queue",
            "--receipt-handle",
            "test-receipt-handle",
            "--visibility-timeout",
            "30",
        ],
        "change-message-visibility-batch": [
            "--queue-name",
            "iam-test-queue",
            "--entries",
            '[{"Id":"1","ReceiptHandle":"test-receipt-handle","VisibilityTimeout":30}]',
        ],
        "list-dead-letter-source-queues": ["--queue-name", "iam-test-queue"],
    },
    "s3": {
        "list-buckets": [],
        "create-bucket": ["--bucket", "iam-test-bucket"],
        "delete-bucket": ["--bucket", "iam-test-bucket"],
        "head-bucket": ["--bucket", "iam-test-bucket"],
        "list-objects-v2": ["--bucket", "iam-test-bucket"],
        "get-bucket-location": ["--bucket", "iam-test-bucket"],
        "get-bucket-tagging": ["--bucket", "iam-test-bucket"],
        "put-bucket-tagging": [
            "--bucket",
            "iam-test-bucket",
            "--tagging",
            '{"TagSet":[{"Key":"k","Value":"v"}]}',
        ],
        "delete-bucket-tagging": ["--bucket", "iam-test-bucket"],
        "get-bucket-policy": ["--bucket", "iam-test-bucket"],
        "put-bucket-policy": [
            "--bucket",
            "iam-test-bucket",
            "--policy",
            '{"Version":"2012-10-17","Statement":[]}',
        ],
        "get-bucket-notification-configuration": ["--bucket", "iam-test-bucket"],
        "put-bucket-notification-configuration": [
            "--bucket",
            "iam-test-bucket",
            "--notification-configuration",
            "{}",
        ],
        "get-bucket-website": ["--bucket", "iam-test-bucket"],
        "put-bucket-website": [
            "--bucket",
            "iam-test-bucket",
            "--website-configuration",
            '{"IndexDocument":{"Suffix":"index.html"}}',
        ],
        "delete-bucket-website": ["--bucket", "iam-test-bucket"],
        "get-object": ["--bucket", "iam-test-bucket", "--key", "iam-test-key"],
        "put-object": [
            "--bucket",
            "iam-test-bucket",
            "--key",
            "iam-test-key",
            "--body",
            "/dev/null",
        ],
        "delete-object": ["--bucket", "iam-test-bucket", "--key", "iam-test-key"],
        "head-object": ["--bucket", "iam-test-bucket", "--key", "iam-test-key"],
        "copy-object": [
            "--bucket",
            "iam-test-bucket",
            "--key",
            "iam-test-dest-key",
            "--copy-source",
            "iam-test-bucket/iam-test-key",
        ],
        "delete-objects": [
            "--bucket",
            "iam-test-bucket",
            "--delete",
            '{"Objects":[{"Key":"iam-test-key"}]}',
        ],
        "create-multipart-upload": ["--bucket", "iam-test-bucket", "--key", "iam-test-key"],
        "upload-part": [
            "--bucket",
            "iam-test-bucket",
            "--key",
            "iam-test-key",
            "--upload-id",
            "test-upload-id",
            "--part-number",
            "1",
            "--body",
            "/dev/null",
        ],
        "complete-multipart-upload": [
            "--bucket",
            "iam-test-bucket",
            "--key",
            "iam-test-key",
            "--upload-id",
            "test-upload-id",
            "--multipart-upload",
            '{"Parts":[{"ETag":"etag","PartNumber":1}]}',
        ],
        "abort-multipart-upload": [
            "--bucket",
            "iam-test-bucket",
            "--key",
            "iam-test-key",
            "--upload-id",
            "test-upload-id",
        ],
        "list-parts": [
            "--bucket",
            "iam-test-bucket",
            "--key",
            "iam-test-key",
            "--upload-id",
            "test-upload-id",
        ],
    },
    "sns": {
        "list-topics": [],
        "list-subscriptions": [],
        "create-topic": ["--name", "iam-test-topic"],
        "delete-topic": [
            "--topic-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
        ],
        "publish": ["--topic-name", "iam-test-topic", "--message", "test-message"],
        "subscribe": [
            "--topic-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
            "--protocol",
            "sqs",
            "--notification-endpoint",
            "arn:aws:sqs:us-east-1:000000000000:iam-test-queue",
        ],
        "unsubscribe": [
            "--subscription-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic:sub-id",
        ],
        "get-topic-attributes": [
            "--topic-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
        ],
        "set-topic-attributes": [
            "--topic-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
            "--attribute-name",
            "DisplayName",
            "--attribute-value",
            "Test",
        ],
        "get-subscription-attributes": [
            "--subscription-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic:sub-id",
        ],
        "set-subscription-attributes": [
            "--subscription-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic:sub-id",
            "--attribute-name",
            "RawMessageDelivery",
            "--attribute-value",
            "true",
        ],
        "confirm-subscription": [
            "--topic-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
            "--token",
            "test-confirm-token",
        ],
        "list-subscriptions-by-topic": [
            "--topic-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
        ],
        "list-tags-for-resource": [
            "--resource-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
        ],
        "tag-resource": [
            "--resource-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
            "--tags",
            '[{"Key":"k","Value":"v"}]',
        ],
        "untag-resource": [
            "--resource-arn",
            "arn:aws:sns:us-east-1:000000000000:iam-test-topic",
            "--tag-keys",
            '["k"]',
        ],
    },
    "events": {
        "list-rules": [],
        "list-event-buses": [],
        "describe-event-bus": [],
        "create-event-bus": ["--name", "iam-test-bus"],
        "delete-event-bus": ["--name", "iam-test-bus"],
        "put-rule": ["--name", "iam-test-rule", "--event-pattern", '{"source":["test"]}'],
        "delete-rule": ["--name", "iam-test-rule"],
        "describe-rule": ["--name", "iam-test-rule"],
        "put-targets": [
            "--rule",
            "iam-test-rule",
            "--targets",
            '[{"Id":"1","Arn":"arn:aws:sqs:us-east-1:000000000000:iam-test-queue"}]',
        ],
        "remove-targets": ["--rule", "iam-test-rule", "--ids", '["1"]'],
        "list-targets-by-rule": ["--rule", "iam-test-rule"],
        "enable-rule": ["--name", "iam-test-rule"],
        "disable-rule": ["--name", "iam-test-rule"],
        "put-events": [
            "--entries",
            '[{"Source":"test","DetailType":"test","Detail":"{}"}]',
        ],
        "list-tags-for-resource": [
            "--resource-arn",
            "arn:aws:events:us-east-1:000000000000:rule/iam-test-rule",
        ],
        "tag-resource": [
            "--resource-arn",
            "arn:aws:events:us-east-1:000000000000:rule/iam-test-rule",
            "--tags",
            '[{"Key":"k","Value":"v"}]',
        ],
        "untag-resource": [
            "--resource-arn",
            "arn:aws:events:us-east-1:000000000000:rule/iam-test-rule",
            "--tag-keys",
            '["k"]',
        ],
    },
    "stepfunctions": {
        "list-state-machines": [],
        "create-state-machine": [
            "--name",
            "iam-test-sm",
            "--definition",
            '{"Comment":"test","StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}',
        ],
        "delete-state-machine": ["--name", "iam-test-sm"],
        "describe-state-machine": ["--name", "iam-test-sm"],
        "update-state-machine": [
            "--name",
            "iam-test-sm",
            "--definition",
            '{"Comment":"test","StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}',
        ],
        "validate-state-machine-definition": [
            "--definition",
            '{"Comment":"test","StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}',
        ],
        "list-state-machine-versions": ["--name", "iam-test-sm"],
        "start-execution": ["--name", "iam-test-sm"],
        "start-sync-execution": ["--name", "iam-test-sm"],
        "stop-execution": [
            "--execution-arn",
            "arn:aws:states:us-east-1:000000000000:execution:iam-test-sm:exec-id",
        ],
        "describe-execution": [
            "--execution-arn",
            "arn:aws:states:us-east-1:000000000000:execution:iam-test-sm:exec-id",
        ],
        "list-executions": ["--name", "iam-test-sm"],
        "get-execution-history": [
            "--execution-arn",
            "arn:aws:states:us-east-1:000000000000:execution:iam-test-sm:exec-id",
        ],
        "list-tags-for-resource": [
            "--resource-arn",
            "arn:aws:states:us-east-1:000000000000:stateMachine:iam-test-sm",
        ],
        "tag-resource": [
            "--resource-arn",
            "arn:aws:states:us-east-1:000000000000:stateMachine:iam-test-sm",
            "--tags",
            '[{"Key":"k","Value":"v"}]',
        ],
        "untag-resource": [
            "--resource-arn",
            "arn:aws:states:us-east-1:000000000000:stateMachine:iam-test-sm",
            "--tag-keys",
            '["k"]',
        ],
    },
    "cognito-idp": {
        "list-user-pools": [],
        "create-user-pool": ["--pool-name", "iam-test-pool"],
        "delete-user-pool": ["--user-pool-id", "us-east-1_iamtest"],
        "describe-user-pool": ["--user-pool-id", "us-east-1_iamtest"],
        "update-user-pool": ["--user-pool-id", "us-east-1_iamtest"],
        "create-user-pool-client": [
            "--user-pool-id",
            "us-east-1_iamtest",
            "--client-name",
            "iam-test-client",
        ],
        "delete-user-pool-client": [
            "--user-pool-id",
            "us-east-1_iamtest",
            "--client-id",
            "test-client-id",
        ],
        "describe-user-pool-client": [
            "--user-pool-id",
            "us-east-1_iamtest",
            "--client-id",
            "test-client-id",
        ],
        "list-user-pool-clients": ["--user-pool-id", "us-east-1_iamtest"],
        "admin-get-user": [
            "--user-pool-id",
            "us-east-1_iamtest",
            "--username",
            "iam-test-user",
        ],
        "admin-create-user": [
            "--user-pool-id",
            "us-east-1_iamtest",
            "--username",
            "iam-test-user",
        ],
        "admin-delete-user": [
            "--user-pool-id",
            "us-east-1_iamtest",
            "--username",
            "iam-test-user",
        ],
        "list-users": ["--user-pool-id", "us-east-1_iamtest"],
        "sign-up": [
            "--user-pool-name",
            "iam-test-pool",
            "--username",
            "iam-test-user",
            "--password",
            "Test1234!",
        ],
        "confirm-sign-up": [
            "--user-pool-name",
            "iam-test-pool",
            "--username",
            "iam-test-user",
        ],
        "initiate-auth": [
            "--user-pool-name",
            "iam-test-pool",
            "--username",
            "iam-test-user",
            "--password",
            "Test1234!",
        ],
        "forgot-password": [
            "--user-pool-name",
            "iam-test-pool",
            "--username",
            "iam-test-user",
        ],
        "confirm-forgot-password": [
            "--user-pool-name",
            "iam-test-pool",
            "--username",
            "iam-test-user",
            "--confirmation-code",
            "123456",
            "--password",
            "Test1234!",
        ],
        "change-password": [
            "--access-token",
            "test-access-token",
            "--previous-password",
            "Test1234!",
            "--proposed-password",
            "Test5678!",
        ],
        "global-sign-out": ["--access-token", "test-access-token"],
    },
    "ssm": {
        "describe-parameters": [],
        "get-parameter": ["--name", "/iam/test/param"],
        "get-parameters": ["--names", '["/iam/test/param"]'],
        "get-parameters-by-path": ["--path", "/iam/test"],
        "put-parameter": ["--name", "/iam/test/param", "--value", "test-value"],
        "delete-parameter": ["--name", "/iam/test/param"],
        "delete-parameters": ["--names", '["/iam/test/param"]'],
        "add-tags-to-resource": [
            "--resource-type",
            "Parameter",
            "--resource-id",
            "/iam/test/param",
            "--tags",
            '[{"Key":"k","Value":"v"}]',
        ],
        "remove-tags-from-resource": [
            "--resource-type",
            "Parameter",
            "--resource-id",
            "/iam/test/param",
            "--tag-keys",
            '["k"]',
        ],
        "list-tags-for-resource": [
            "--resource-type",
            "Parameter",
            "--resource-id",
            "/iam/test/param",
        ],
    },
    "secretsmanager": {
        "list-secrets": [],
        "create-secret": ["--name", "iam/test/secret", "--secret-string", "test-value"],
        "get-secret-value": ["--secret-id", "iam/test/secret"],
        "put-secret-value": [
            "--secret-id",
            "iam/test/secret",
            "--secret-string",
            "test-value",
        ],
        "describe-secret": ["--secret-id", "iam/test/secret"],
        "update-secret": [
            "--secret-id",
            "iam/test/secret",
            "--secret-string",
            "new-value",
        ],
        "delete-secret": [
            "--secret-id",
            "iam/test/secret",
            "--force-delete-without-recovery",
        ],
        "restore-secret": ["--secret-id", "iam/test/secret"],
        "list-secret-version-ids": ["--secret-id", "iam/test/secret"],
        "get-resource-policy": ["--secret-id", "iam/test/secret"],
        "tag-resource": [
            "--secret-id",
            "iam/test/secret",
            "--tags",
            '[{"Key":"k","Value":"v"}]',
        ],
        "untag-resource": ["--secret-id", "iam/test/secret", "--tag-keys", '["k"]'],
    },
}

# S3 uses "s3api" as the CLI sub-command prefix.
_CLI_PREFIX: dict[str, str] = {
    "s3": "s3api",
}


# ---------------------------------------------------------------------------
# Session fixture – register test identities once at E2E startup
# ---------------------------------------------------------------------------


@pytest.fixture(scope="session", autouse=True)
def iam_test_identities(e2e_port, ldk_server):
    """Register test identities into the running server's IAM identity store."""
    _ = ldk_server
    url = f"http://localhost:{e2e_port}/_ldk/iam-auth"
    payload = {
        "identities": {
            "lws-test-full-access": {
                "inline_policies": [_FULL_ACCESS_POLICY],
            },
            "lws-test-no-perms": {
                "inline_policies": [],
            },
        }
    }
    data = json.dumps(payload).encode()
    req = urllib.request.Request(url, data=data, headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req) as resp:
        if resp.status != 200:
            raise RuntimeError(f"Failed to register test identities: status {resp.status}")


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _set_iam_mode(e2e_port: int, service: str, mode: str) -> None:
    """Set IAM auth mode for a service via management API."""
    result = runner.invoke(
        app,
        ["iam-auth", "set", service, "--mode", mode, "--port", str(e2e_port)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (iam-auth set {service} {mode}): {result.output}")


def _set_iam_identity(e2e_port: int, identity: str) -> None:
    """Set the global default identity via management API."""
    result = runner.invoke(
        app,
        ["iam-auth", "set-identity", identity, "--port", str(e2e_port)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (iam-auth set-identity {identity}): {result.output}")


def _disable_iam(e2e_port: int, service: str) -> None:
    """Disable IAM auth for a service."""
    runner.invoke(
        app,
        ["iam-auth", "disable", service, "--port", str(e2e_port)],
    )


# ---------------------------------------------------------------------------
# Given steps
# ---------------------------------------------------------------------------


@given(
    parsers.parse('IAM auth was enabled for "{service}" with mode "{mode}"'),
    target_fixture="given_iam_auth",
)
def iam_auth_was_enabled(service, mode, e2e_port):
    _set_iam_mode(e2e_port, service, mode)
    return {"service": service, "mode": mode}


@given(
    parsers.parse('IAM auth was disabled for "{service}"'),
    target_fixture="given_iam_auth",
)
def iam_auth_was_disabled(service, e2e_port):
    _disable_iam(e2e_port, service)
    return {"service": service, "mode": "disabled"}


@given(
    parsers.parse('IAM auth was set for "{service}" with mode "{mode}"'),
    target_fixture="given_iam_auth",
)
def iam_auth_was_set(service, mode, e2e_port):
    _set_iam_mode(e2e_port, service, mode)
    return {"service": service, "mode": mode}


@given(
    parsers.parse('IAM auth was set for "{service}" with mode "{mode}" and identity "{identity}"'),
    target_fixture="given_iam_auth",
)
def iam_auth_was_set_with_identity(service, mode, identity, e2e_port, iam_test_identities):
    """Set IAM auth mode and default identity for a service."""
    _ = iam_test_identities
    _set_iam_mode(e2e_port, service, mode)
    _set_iam_identity(e2e_port, identity)
    return {"service": service, "mode": mode, "identity": identity}


# ---------------------------------------------------------------------------
# When steps
# ---------------------------------------------------------------------------


@when("I list DynamoDB tables", target_fixture="command_result")
def i_list_dynamodb_tables(e2e_port):
    return runner.invoke(
        app,
        ["dynamodb", "list-tables", "--port", str(e2e_port)],
    )


@when("I describe SSM parameters", target_fixture="command_result")
def i_describe_ssm_parameters(e2e_port):
    return runner.invoke(
        app,
        ["ssm", "describe-parameters", "--port", str(e2e_port)],
    )


@when("I list Secrets Manager secrets", target_fixture="command_result")
def i_list_secretsmanager_secrets(e2e_port):
    return runner.invoke(
        app,
        ["secretsmanager", "list-secrets", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I call "{service}" "{operation}"'),
    target_fixture="command_result",
)
def i_call_service_operation(service, operation, e2e_port):
    cli_prefix = _CLI_PREFIX.get(service, service)
    extra_args = _OPERATION_ARGS.get(service, {}).get(operation, [])
    return runner.invoke(
        app,
        [cli_prefix, operation] + extra_args + ["--port", str(e2e_port)],
    )


# ---------------------------------------------------------------------------
# Then steps
# ---------------------------------------------------------------------------


def _output_has_access_denied(output: object) -> bool:
    """Return True if output contains an IAM access denied error in any supported format."""
    if not isinstance(output, dict):
        return False
    # JSON format: {"__type": "AccessDeniedException", ...}
    if "AccessDenied" in output.get("__type", ""):
        return True
    # XML_IAM format (SQS, SNS): {"ErrorResponse": {"Error": {"Code": "AccessDeniedException"}}}
    if "AccessDenied" in output.get("ErrorResponse", {}).get("Error", {}).get("Code", ""):
        return True
    # XML_S3 format: {"Error": {"Code": "AccessDenied", ...}}
    error_val = output.get("Error", {})
    if isinstance(error_val, dict) and "AccessDenied" in error_val.get("Code", ""):
        return True
    return False


@then("the output will contain an IAM access denied error")
def output_will_contain_iam_access_denied(command_result, parse_output):
    output = parse_output(command_result.output)
    assert _output_has_access_denied(output), f"Expected AccessDenied error, got: {output}"


@then("the output will not contain an IAM access denied error")
def output_will_not_contain_iam_access_denied(command_result, parse_output):
    output = parse_output(command_result.output)
    assert not _output_has_access_denied(
        output
    ), f"Unexpected IAM access denied in output: {output}"


@then(
    parsers.parse('IAM auth was cleaned up for "{service}"'),
)
def iam_auth_was_cleaned_up(service, e2e_port):
    _disable_iam(e2e_port, service)
    _set_iam_identity(e2e_port, "lws-test-no-perms")
