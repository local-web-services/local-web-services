"""Shared fixtures for lambda_function_url E2E tests."""

from __future__ import annotations

import json

import pytest
from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


@pytest.fixture(autouse=True)
def _cleanup_function_urls(e2e_port):
    """Delete all function URL configs after each test to prevent leaking."""
    yield
    result = runner.invoke(
        app,
        ["lambda", "list-function-url-configs", "--port", str(e2e_port)],
    )
    if result.exit_code == 0:
        try:
            data = json.loads(result.output)
            for url_config in data.get("FunctionUrlConfigs", []):
                fname = url_config.get("FunctionName", "")
                if fname:
                    runner.invoke(
                        app,
                        [
                            "lambda",
                            "delete-function-url-config",
                            "--function-name",
                            fname,
                            "--port",
                            str(e2e_port),
                        ],
                    )
        except (json.JSONDecodeError, ValueError):
            pass


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a Lambda function "{function_name}" was created'),
    target_fixture="given_function",
)
def a_lambda_function_was_created(function_name, lws_invoke, e2e_port):
    code_json = json.dumps({"ZipFile": ""})
    lws_invoke(
        [
            "lambda",
            "create-function",
            "--function-name",
            function_name,
            "--runtime",
            "python3.12",
            "--handler",
            "index.handler",
            "--code",
            code_json,
            "--port",
            str(e2e_port),
        ]
    )
    return {"function_name": function_name}


@given(
    parsers.parse('a function URL config for "{function_name}" was created'),
)
def a_function_url_config_was_created(function_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "lambda",
            "create-function-url-config",
            "--function-name",
            function_name,
            "--port",
            str(e2e_port),
        ]
    )


@when(
    parsers.parse('I create a function URL config for "{function_name}"'),
    target_fixture="command_result",
)
def i_create_function_url_config(function_name, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "create-function-url-config",
            "--function-name",
            function_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get the function URL config for "{function_name}"'),
    target_fixture="command_result",
)
def i_get_function_url_config(function_name, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "get-function-url-config",
            "--function-name",
            function_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete the function URL config for "{function_name}"'),
    target_fixture="command_result",
)
def i_delete_function_url_config(function_name, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "delete-function-url-config",
            "--function-name",
            function_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list function URL configs",
    target_fixture="command_result",
)
def i_list_function_url_configs(e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "list-function-url-configs",
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('the output will contain function URL for "{function_name}"'),
)
def the_output_will_contain_function_url(function_name, command_result, parse_output):
    data = parse_output(command_result.output)
    actual_function_name = data.get("FunctionName", "")
    assert actual_function_name == function_name


@then(
    parsers.parse('the output will contain function name "{function_name}"'),
)
def the_output_will_contain_function_name(function_name, command_result, parse_output):
    data = parse_output(command_result.output)
    actual_function_name = data.get("FunctionName", "")
    assert actual_function_name == function_name


@then(
    parsers.parse('function "{function_name}" will have no URL config'),
)
def function_will_have_no_url_config(function_name, e2e_port):
    result = runner.invoke(
        app,
        [
            "lambda",
            "get-function-url-config",
            "--function-name",
            function_name,
            "--port",
            str(e2e_port),
        ],
    )
    assert result.exit_code != 0 or "not found" in result.output.lower()


@then(
    parsers.parse('the output will contain "{expected_key}"'),
)
def the_output_will_contain_key(expected_key, command_result, parse_output):
    data = parse_output(command_result.output)
    assert expected_key in data
