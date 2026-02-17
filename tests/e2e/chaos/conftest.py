"""Shared fixtures for chaos E2E tests."""

from __future__ import annotations

import json

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


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
