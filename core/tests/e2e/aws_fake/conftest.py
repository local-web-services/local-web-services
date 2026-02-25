"""Shared fixtures for AWS fake E2E tests."""

from __future__ import annotations

import shutil
from pathlib import Path

import pytest
from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

_ALL_FAKE_SERVICES = [
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
def _cleanup_all_fakes(e2e_port):
    """Disable all AWS fake rules after each test to prevent leaking."""
    yield
    for svc in _ALL_FAKE_SERVICES:
        runner.invoke(
            app,
            ["aws-fake", "disable", svc, "--port", str(e2e_port)],
        )


def _project_dir() -> Path:
    """Return the resolved project directory (cwd)."""
    return Path(".").resolve()


_XML_SERVICES = {"sqs", "sns", "s3"}

_FAKE_BODIES = {
    "sqs": (
        "<ListQueuesResponse><ListQueuesResult>"
        "<QueueUrl>faked</QueueUrl>"
        "</ListQueuesResult></ListQueuesResponse>"
    ),
    "s3": (
        "<ListAllMyBucketsResult><Buckets>"
        "<Bucket><Name>faked</Name></Bucket>"
        "</Buckets></ListAllMyBucketsResult>"
    ),
    "sns": (
        "<ListTopicsResponse><ListTopicsResult><Topics>"
        "<member><TopicArn>faked</TopicArn></member>"
        "</Topics></ListTopicsResult></ListTopicsResponse>"
    ),
}


def _configure_fake_rule(
    e2e_port: int,
    service: str,
    operation: str,
    body: str | None = None,
    match_headers: dict | None = None,
) -> None:
    """Enable an AWS fake rule via the set-rules CLI command."""
    if body is None:
        body = _FAKE_BODIES.get(service, '{"faked": true}')
    content_type = "text/xml" if service in _XML_SERVICES else "application/json"
    args = [
        "aws-fake",
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
        raise RuntimeError(f"Arrange failed (aws-fake set-rules): {result.output}")


def _disable_fake(e2e_port: int, service: str) -> None:
    """Disable AWS fake rules via the CLI."""
    runner.invoke(
        app,
        ["aws-fake", "disable", service, "--port", str(e2e_port)],
    )


# ── Given steps (control plane) ─────────────────────────────────


@given(
    parsers.parse('an AWS fake "{name}" for service "{service}" was created'),
    target_fixture="given_aws_fake",
)
def an_aws_fake_was_created(name, service):
    result = runner.invoke(
        app,
        [
            "aws-fake",
            "create",
            name,
            "--service",
            service,
            "--project-dir",
            str(_project_dir()),
        ],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (aws-fake create): {result.output}")
    return {"name": name, "service": service}


@given(
    parsers.parse('operation "{operation}" was added to AWS fake "{name}"'),
    target_fixture="given_operation",
)
def operation_was_added(operation, name):
    result = runner.invoke(
        app,
        [
            "aws-fake",
            "add-operation",
            name,
            "--operation",
            operation,
            "--status",
            "200",
            "--body",
            '{"faked": true}',
            "--project-dir",
            str(_project_dir()),
        ],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (add-operation): {result.output}")
    return {"operation": operation}


# ── Given steps (data plane) ────────────────────────────────────


@given(
    parsers.parse('an AWS fake rule for "{service}" operation ' '"{operation}" was configured'),
    target_fixture="given_fake_rule",
)
def fake_rule_was_configured(service, operation, e2e_port):
    _configure_fake_rule(e2e_port, service, operation)
    return {"service": service, "operation": operation}


@given(
    parsers.parse(
        'an AWS fake rule for "{service}" operation '
        '"{operation}" with header filter was configured'
    ),
    target_fixture="given_fake_rule",
)
def fake_rule_with_header_was_configured(service, operation, e2e_port):
    _configure_fake_rule(
        e2e_port,
        service,
        operation,
        body='{"header-filtered-fake": true}',
        match_headers={"x-e2e-test": "special"},
    )
    return {"service": service, "operation": operation}


# ── When steps (control plane) ──────────────────────────────────


@when(
    parsers.parse('I create an AWS fake "{name}" for service "{service}"'),
    target_fixture="command_result",
)
def i_create_aws_fake(name, service):
    return runner.invoke(
        app,
        [
            "aws-fake",
            "create",
            name,
            "--service",
            service,
            "--project-dir",
            str(_project_dir()),
        ],
    )


@when(
    parsers.parse('I delete the AWS fake "{name}"'),
    target_fixture="command_result",
)
def i_delete_aws_fake(name):
    return runner.invoke(
        app,
        [
            "aws-fake",
            "delete",
            name,
            "--yes",
            "--project-dir",
            str(_project_dir()),
        ],
    )


@when(
    "I list AWS fakes",
    target_fixture="command_result",
)
def i_list_aws_fakes():
    return runner.invoke(
        app,
        [
            "aws-fake",
            "list",
            "--project-dir",
            str(_project_dir()),
        ],
    )


@when(
    parsers.parse(
        'I add operation "{operation}" to AWS fake "{name}"'
        ' with status {status:d} and body "{body}"'
    ),
    target_fixture="command_result",
)
def i_add_operation(operation, name, status, body):
    return runner.invoke(
        app,
        [
            "aws-fake",
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
    parsers.parse('I remove operation "{operation}" from AWS fake "{name}"'),
    target_fixture="command_result",
)
def i_remove_operation(operation, name):
    return runner.invoke(
        app,
        [
            "aws-fake",
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
    parsers.parse('the AWS fake "{name}" was cleaned up'),
)
def aws_fake_was_cleaned_up(name):
    fake_dir = _project_dir() / ".lws" / "fakes" / name
    if fake_dir.exists():
        shutil.rmtree(fake_dir)


@then(
    parsers.parse('the AWS fake rule for "{service}" was cleaned up'),
)
def aws_fake_rule_was_cleaned_up(service, e2e_port):
    _disable_fake(e2e_port, service)
