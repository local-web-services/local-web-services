"""Shared fixtures for AWS mock E2E tests."""

from __future__ import annotations

import shutil
from pathlib import Path

import pytest
from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

_ALL_MOCK_SERVICES = [
    "dynamodb",
    "sqs",
    "s3",
    "sns",
    "events",
    "stepfunctions",
    "cognito-idp",
    "ssm",
    "secretsmanager",
]


@pytest.fixture(autouse=True)
def _cleanup_all_mocks(e2e_port):
    """Disable all AWS mock rules after each test to prevent leaking."""
    yield
    for svc in _ALL_MOCK_SERVICES:
        runner.invoke(
            app,
            ["aws-mock", "disable", svc, "--port", str(e2e_port)],
        )


def _project_dir() -> Path:
    """Return the resolved project directory (cwd)."""
    return Path(".").resolve()


_XML_SERVICES = {"sqs", "sns", "s3"}

_MOCK_BODIES = {
    "sqs": (
        "<ListQueuesResponse><ListQueuesResult>"
        "<QueueUrl>mocked</QueueUrl>"
        "</ListQueuesResult></ListQueuesResponse>"
    ),
    "s3": (
        "<ListAllMyBucketsResult><Buckets>"
        "<Bucket><Name>mocked</Name></Bucket>"
        "</Buckets></ListAllMyBucketsResult>"
    ),
    "sns": (
        "<ListTopicsResponse><ListTopicsResult><Topics>"
        "<member><TopicArn>mocked</TopicArn></member>"
        "</Topics></ListTopicsResult></ListTopicsResponse>"
    ),
}


def _configure_mock_rule(
    e2e_port: int,
    service: str,
    operation: str,
    body: str | None = None,
    match_headers: dict | None = None,
) -> None:
    """Enable an AWS mock rule via the set-rules CLI command."""
    if body is None:
        body = _MOCK_BODIES.get(service, '{"mocked": true}')
    content_type = "text/xml" if service in _XML_SERVICES else "application/json"
    args = [
        "aws-mock",
        "set-rules",
        service,
        "--operation",
        operation,
        "--status",
        "200",
        "--body",
        body,
        "--content-type",
        content_type,
        "--port",
        str(e2e_port),
    ]
    if match_headers:
        for key, val in match_headers.items():
            args.extend(["--match-header", f"{key}={val}"])

    result = runner.invoke(app, args)
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (aws-mock set-rules): {result.output}")


def _disable_mock(e2e_port: int, service: str) -> None:
    """Disable AWS mock rules via the CLI."""
    runner.invoke(
        app,
        ["aws-mock", "disable", service, "--port", str(e2e_port)],
    )


# ── Given steps (control plane) ─────────────────────────────────


@given(
    parsers.parse('an AWS mock "{name}" for service "{service}" was created'),
    target_fixture="given_aws_mock",
)
def an_aws_mock_was_created(name, service):
    result = runner.invoke(
        app,
        [
            "aws-mock",
            "create",
            name,
            "--service",
            service,
            "--project-dir",
            str(_project_dir()),
        ],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (aws-mock create): {result.output}")
    return {"name": name, "service": service}


@given(
    parsers.parse('operation "{operation}" was added to AWS mock "{name}"'),
    target_fixture="given_operation",
)
def operation_was_added(operation, name):
    result = runner.invoke(
        app,
        [
            "aws-mock",
            "add-operation",
            name,
            "--operation",
            operation,
            "--status",
            "200",
            "--body",
            '{"mocked": true}',
            "--project-dir",
            str(_project_dir()),
        ],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (add-operation): {result.output}")
    return {"operation": operation}


# ── Given steps (data plane) ────────────────────────────────────


@given(
    parsers.parse('an AWS mock rule for "{service}" operation ' '"{operation}" was configured'),
    target_fixture="given_mock_rule",
)
def mock_rule_was_configured(service, operation, e2e_port):
    _configure_mock_rule(e2e_port, service, operation)
    return {"service": service, "operation": operation}


@given(
    parsers.parse(
        'an AWS mock rule for "{service}" operation '
        '"{operation}" with header filter was configured'
    ),
    target_fixture="given_mock_rule",
)
def mock_rule_with_header_was_configured(service, operation, e2e_port):
    _configure_mock_rule(
        e2e_port,
        service,
        operation,
        body='{"header-filtered-mock": true}',
        match_headers={"x-e2e-test": "special"},
    )
    return {"service": service, "operation": operation}


# ── When steps (control plane) ──────────────────────────────────


@when(
    parsers.parse('I create an AWS mock "{name}" for service "{service}"'),
    target_fixture="command_result",
)
def i_create_aws_mock(name, service):
    return runner.invoke(
        app,
        [
            "aws-mock",
            "create",
            name,
            "--service",
            service,
            "--project-dir",
            str(_project_dir()),
        ],
    )


@when(
    parsers.parse('I delete the AWS mock "{name}"'),
    target_fixture="command_result",
)
def i_delete_aws_mock(name):
    return runner.invoke(
        app,
        [
            "aws-mock",
            "delete",
            name,
            "--yes",
            "--project-dir",
            str(_project_dir()),
        ],
    )


@when(
    "I list AWS mocks",
    target_fixture="command_result",
)
def i_list_aws_mocks():
    return runner.invoke(
        app,
        [
            "aws-mock",
            "list",
            "--project-dir",
            str(_project_dir()),
        ],
    )


@when(
    parsers.parse(
        'I add operation "{operation}" to AWS mock "{name}"'
        ' with status {status:d} and body "{body}"'
    ),
    target_fixture="command_result",
)
def i_add_operation(operation, name, status, body):
    return runner.invoke(
        app,
        [
            "aws-mock",
            "add-operation",
            name,
            "--operation",
            operation,
            "--status",
            str(status),
            "--body",
            body,
            "--project-dir",
            str(_project_dir()),
        ],
    )


@when(
    parsers.parse('I remove operation "{operation}" from AWS mock "{name}"'),
    target_fixture="command_result",
)
def i_remove_operation(operation, name):
    return runner.invoke(
        app,
        [
            "aws-mock",
            "remove-operation",
            name,
            "--operation",
            operation,
            "--project-dir",
            str(_project_dir()),
        ],
    )


# ── When steps (data plane) ─────────────────────────────────────


@when("I list DynamoDB tables", target_fixture="command_result")
def i_list_dynamodb_tables(e2e_port):
    return runner.invoke(
        app,
        ["dynamodb", "list-tables", "--port", str(e2e_port)],
    )


@when("I list SQS queues", target_fixture="command_result")
def i_list_sqs_queues(e2e_port):
    return runner.invoke(
        app,
        ["sqs", "list-queues", "--port", str(e2e_port)],
    )


@when("I list S3 buckets", target_fixture="command_result")
def i_list_s3_buckets(e2e_port):
    return runner.invoke(
        app,
        ["s3api", "list-buckets", "--port", str(e2e_port)],
    )


@when("I list SNS topics", target_fixture="command_result")
def i_list_sns_topics(e2e_port):
    return runner.invoke(
        app,
        ["sns", "list-topics", "--port", str(e2e_port)],
    )


@when(
    "I list Step Functions state machines",
    target_fixture="command_result",
)
def i_list_stepfunctions_state_machines(e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "list-state-machines",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list EventBridge event buses",
    target_fixture="command_result",
)
def i_list_eventbridge_event_buses(e2e_port):
    return runner.invoke(
        app,
        ["events", "list-event-buses", "--port", str(e2e_port)],
    )


@when("I list Cognito user pools", target_fixture="command_result")
def i_list_cognito_user_pools(e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "list-user-pools",
            "--port",
            str(e2e_port),
        ],
    )


@when("I describe SSM parameters", target_fixture="command_result")
def i_describe_ssm_parameters(e2e_port):
    return runner.invoke(
        app,
        ["ssm", "describe-parameters", "--port", str(e2e_port)],
    )


@when(
    "I list Secrets Manager secrets",
    target_fixture="command_result",
)
def i_list_secretsmanager_secrets(e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "list-secrets",
            "--port",
            str(e2e_port),
        ],
    )


# ── Then steps ──────────────────────────────────────────────────


@then(
    parsers.parse('the output will contain "{text}"'),
)
def output_will_contain(text, command_result):
    actual_output = command_result.output
    assert text in actual_output, f"Expected '{text}' in output: {actual_output}"


@then(
    parsers.parse('the output will not contain "{text}"'),
)
def output_will_not_contain(text, command_result):
    actual_output = command_result.output
    assert text not in actual_output, f"Did not expect '{text}' in output: {actual_output}"


@then(
    parsers.parse('the AWS mock "{name}" was cleaned up'),
)
def aws_mock_was_cleaned_up(name):
    mock_dir = _project_dir() / ".lws" / "mocks" / name
    if mock_dir.exists():
        shutil.rmtree(mock_dir)


@then(
    parsers.parse('the AWS mock rule for "{service}" was cleaned up'),
)
def aws_mock_rule_was_cleaned_up(service, e2e_port):
    _disable_mock(e2e_port, service)
