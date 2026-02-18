"""Shared fixtures for chaos E2E tests."""

from __future__ import annotations

import json

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _enable_chaos_full_error_rate(e2e_port: int, service: str) -> None:
    """Enable chaos with 100% error rate for a service."""
    result = runner.invoke(
        app,
        ["chaos", "enable", service, "--port", str(e2e_port)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (chaos enable): {result.output}")
    result = runner.invoke(
        app,
        ["chaos", "set", service, "--error-rate", "1.0", "--port", str(e2e_port)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (chaos set): {result.output}")


def _disable_chaos(e2e_port: int, service: str) -> None:
    """Disable chaos and reset error rate for a service."""
    runner.invoke(
        app,
        ["chaos", "set", service, "--error-rate", "0.0", "--port", str(e2e_port)],
    )
    runner.invoke(
        app,
        ["chaos", "disable", service, "--port", str(e2e_port)],
    )


# ── Given steps ──────────────────────────────────────────────────


@given(
    parsers.parse('chaos was enabled for "{service}"'),
    target_fixture="given_chaos",
)
def chaos_was_enabled(service, e2e_port):
    result = runner.invoke(
        app,
        ["chaos", "enable", service, "--port", str(e2e_port)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (chaos enable): {result.output}")
    return {"service": service}


@given(
    parsers.parse('chaos was configured for "{service}" with full error rate'),
    target_fixture="given_chaos",
)
def chaos_was_configured_full_error_rate(service, e2e_port):
    _enable_chaos_full_error_rate(e2e_port, service)
    return {"service": service}


# ── When steps ──────────────────────────────────────────────────


@when(
    parsers.parse('I enable chaos for "{service}"'),
    target_fixture="command_result",
)
def i_enable_chaos(service, e2e_port):
    return runner.invoke(
        app,
        ["chaos", "enable", service, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I disable chaos for "{service}"'),
    target_fixture="command_result",
)
def i_disable_chaos(service, e2e_port):
    return runner.invoke(
        app,
        ["chaos", "disable", service, "--port", str(e2e_port)],
    )


@when("I request chaos status", target_fixture="command_result")
def i_request_chaos_status(e2e_port):
    return runner.invoke(
        app,
        ["chaos", "status", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I set chaos for "{service}" with error rate {rate:g}'),
    target_fixture="command_result",
)
def i_set_chaos_error_rate(service, rate, e2e_port):
    return runner.invoke(
        app,
        [
            "chaos",
            "set",
            service,
            "--error-rate",
            str(rate),
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I set chaos for "{service}" with latency min {min_ms:d} and max {max_ms:d}'),
    target_fixture="command_result",
)
def i_set_chaos_latency(service, min_ms, max_ms, e2e_port):
    return runner.invoke(
        app,
        [
            "chaos",
            "set",
            service,
            "--latency-min",
            str(min_ms),
            "--latency-max",
            str(max_ms),
            "--port",
            str(e2e_port),
        ],
    )


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


@when("I list Step Functions state machines", target_fixture="command_result")
def i_list_stepfunctions_state_machines(e2e_port):
    return runner.invoke(
        app,
        ["stepfunctions", "list-state-machines", "--port", str(e2e_port)],
    )


@when("I list EventBridge event buses", target_fixture="command_result")
def i_list_eventbridge_event_buses(e2e_port):
    return runner.invoke(
        app,
        ["events", "list-event-buses", "--port", str(e2e_port)],
    )


@when("I list Cognito user pools", target_fixture="command_result")
def i_list_cognito_user_pools(e2e_port):
    return runner.invoke(
        app,
        ["cognito", "list-user-pools", "--port", str(e2e_port)],
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


# ── Then steps ──────────────────────────────────────────────────


@then(
    parsers.parse('chaos for "{service}" will be enabled'),
)
def chaos_will_be_enabled(service, e2e_port):
    result = runner.invoke(
        app,
        ["chaos", "status", "--port", str(e2e_port)],
    )
    output = json.loads(result.output)
    actual_enabled = output[service]["enabled"]
    assert actual_enabled is True


@then(
    parsers.parse('chaos for "{service}" will be disabled'),
)
def chaos_will_be_disabled(service, e2e_port):
    result = runner.invoke(
        app,
        ["chaos", "status", "--port", str(e2e_port)],
    )
    output = json.loads(result.output)
    actual_enabled = output[service]["enabled"]
    assert actual_enabled is False


@then(
    parsers.parse('the chaos status will contain "{service}"'),
)
def the_chaos_status_will_contain(service, command_result):
    output = json.loads(command_result.output)
    assert service in output


@then(
    parsers.parse('chaos for "{service}" will have error rate {rate:g}'),
)
def chaos_will_have_error_rate(service, rate, e2e_port):
    result = runner.invoke(
        app,
        ["chaos", "status", "--port", str(e2e_port)],
    )
    output = json.loads(result.output)
    actual_rate = output[service]["error_rate"]
    assert actual_rate == rate


@then(
    parsers.parse('chaos for "{service}" will have latency min {value:d}'),
)
def chaos_will_have_latency_min(service, value, e2e_port):
    result = runner.invoke(
        app,
        ["chaos", "status", "--port", str(e2e_port)],
    )
    output = json.loads(result.output)
    actual_min = output[service]["latency_min_ms"]
    assert actual_min == value


@then(
    parsers.parse('chaos for "{service}" will have latency max {value:d}'),
)
def chaos_will_have_latency_max(service, value, e2e_port):
    result = runner.invoke(
        app,
        ["chaos", "status", "--port", str(e2e_port)],
    )
    output = json.loads(result.output)
    actual_max = output[service]["latency_max_ms"]
    assert actual_max == value


@then("the output will contain a JSON chaos error")
def output_will_contain_json_chaos_error(command_result, parse_output):
    output = parse_output(command_result.output)
    assert "__type" in output, f"Missing __type in: {output}"
    assert "message" in output, f"Missing message in: {output}"


@then("the output will contain an XML chaos error")
def output_will_contain_xml_chaos_error(command_result, parse_output):
    output = parse_output(command_result.output)
    assert "ErrorResponse" in output, f"Missing ErrorResponse in: {output}"
    actual_error = output["ErrorResponse"]["Error"]
    assert "Code" in actual_error, f"Missing Code in: {actual_error}"
    assert "Message" in actual_error, f"Missing Message in: {actual_error}"


@then("the output will contain an S3 XML chaos error")
def output_will_contain_s3_xml_chaos_error(command_result, parse_output):
    output = parse_output(command_result.output)
    assert "Error" in output, f"Missing Error in: {output}"
    actual_error = output["Error"]
    assert "Code" in actual_error, f"Missing Code in: {actual_error}"
    assert "Message" in actual_error, f"Missing Message in: {actual_error}"


@then(
    parsers.parse('chaos was cleaned up for "{service}"'),
)
def chaos_was_cleaned_up(service, e2e_port):
    _disable_chaos(e2e_port, service)
