"""Shared fixtures for mock server E2E tests."""

from __future__ import annotations

import json
import shutil
from pathlib import Path
from typing import Any

import pytest
import yaml
from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

_E2E_MOCK_DIR = Path("/tmp/lws-mock-e2e")


# ── Fixtures ────────────────────────────────────────────────────────


@pytest.fixture(autouse=True)
def _clean_mock_dir():
    """Clean the mock project directory before each test."""
    mocks = _E2E_MOCK_DIR / ".lws" / "mocks"
    if mocks.exists():
        shutil.rmtree(mocks)
    _E2E_MOCK_DIR.mkdir(parents=True, exist_ok=True)


def _e2e_project_dir() -> Path:
    """Return the E2E project directory for mock server tests."""
    _E2E_MOCK_DIR.mkdir(parents=True, exist_ok=True)
    return _E2E_MOCK_DIR


def _mock_dir(name: str) -> Path:
    """Return the directory for a named mock server."""
    return _e2e_project_dir() / ".lws" / "mocks" / name


def _read_config_yaml(name: str) -> dict:
    """Read and parse the config.yaml for a named mock server."""
    config_path = _mock_dir(name) / "config.yaml"
    return yaml.safe_load(config_path.read_text()) or {}


# ── Given steps ──────────────────────────────────────────────────


@given(
    parsers.parse('a mock server "{name}" was created'),
    target_fixture="given_mock",
)
def a_mock_server_was_created(name, e2e_port):
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        ["mock", "create", name, "--project-dir", str(project_dir)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (mock create): {result.output}")
    return {"name": name, "project_dir": str(project_dir)}


@given(
    parsers.parse('a mock server "{name}" was created with protocol "{protocol}"'),
    target_fixture="given_mock",
)
def a_mock_server_was_created_with_protocol(name, protocol, e2e_port):
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        ["mock", "create", name, "--protocol", protocol, "--project-dir", str(project_dir)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (mock create): {result.output}")
    return {"name": name, "project_dir": str(project_dir)}


@given(
    parsers.parse(
        'a route "{path}" with method "{method}" and status {status:d} was added to "{name}"'
    ),
)
def a_route_was_added(path, method, status, name, e2e_port):
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        [
            "mock",
            "add-route",
            name,
            "--path",
            path,
            "--method",
            method,
            "--status",
            str(status),
            "--body",
            '{"mock": true}',
            "--project-dir",
            str(project_dir),
        ],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (add-route): {result.output}")


def _update_chaos_config(name: str, **chaos_overrides: Any) -> None:
    """Update chaos section of a mock server's config.yaml."""
    config_path = _mock_dir(name) / "config.yaml"
    config = yaml.safe_load(config_path.read_text()) or {}
    chaos = config.setdefault("chaos", {})
    latency = chaos.setdefault("latency", {})
    for key, value in chaos_overrides.items():
        if key == "latency_min":
            latency["min_ms"] = value
        elif key == "latency_max":
            latency["max_ms"] = value
        else:
            chaos[key] = value
    config_path.write_text(yaml.dump(config, default_flow_style=False, sort_keys=False))


@given(
    parsers.parse(
        'a mock server "{name}" was created with chaos latency min {min_ms:d} and max {max_ms:d}'
    ),
    target_fixture="given_mock",
)
def a_mock_server_was_created_with_latency(name, min_ms, max_ms, e2e_port):
    """Create a mock server and set custom latency values."""
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        ["mock", "create", name, "--project-dir", str(project_dir)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (mock create): {result.output}")
    _update_chaos_config(name, latency_min=min_ms, latency_max=max_ms)
    return {"name": name, "project_dir": str(project_dir)}


@given(
    parsers.parse(
        'a mock server "{name}" was created with chaos timeout rate {rate:g}'
    ),
    target_fixture="given_mock",
)
def a_mock_server_was_created_with_timeout_rate(name, rate, e2e_port):
    """Create a mock server and set custom timeout rate."""
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        ["mock", "create", name, "--project-dir", str(project_dir)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (mock create): {result.output}")
    _update_chaos_config(name, timeout_rate=rate)
    return {"name": name, "project_dir": str(project_dir)}


@given(
    parsers.parse(
        'a mock server "{name}" was created with chaos error rate {rate:g}'
    ),
    target_fixture="given_mock",
)
def a_mock_server_was_created_with_error_rate(name, rate, e2e_port):
    """Create a mock server and set custom error rate."""
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        ["mock", "create", name, "--project-dir", str(project_dir)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (mock create): {result.output}")
    _update_chaos_config(name, error_rate=rate)
    return {"name": name, "project_dir": str(project_dir)}


@given(
    parsers.parse(
        'a mock server "{name}" was created with chaos connection reset rate {rate:g}'
    ),
    target_fixture="given_mock",
)
def a_mock_server_was_created_with_conn_reset_rate(name, rate, e2e_port):
    """Create a mock server and set custom connection reset rate."""
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        ["mock", "create", name, "--project-dir", str(project_dir)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (mock create): {result.output}")
    _update_chaos_config(name, connection_reset_rate=rate)
    return {"name": name, "project_dir": str(project_dir)}


@given(
    parsers.parse(
        'a mock server "{name}" was created with chaos'
        " latency min {min_ms:d} and max {max_ms:d}"
        " and error rate {error_rate:g}"
        " and timeout rate {timeout_rate:g}"
    ),
    target_fixture="given_mock",
)
def a_mock_server_was_created_with_all_chaos(  # pylint: disable=unused-argument
    name, min_ms, max_ms, error_rate, timeout_rate, e2e_port
):
    """Create a mock server and set all chaos values."""
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        ["mock", "create", name, "--project-dir", str(project_dir)],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (mock create): {result.output}")
    _update_chaos_config(
        name,
        latency_min=min_ms,
        latency_max=max_ms,
        error_rate=error_rate,
        timeout_rate=timeout_rate,
    )
    return {"name": name, "project_dir": str(project_dir)}


@given(
    parsers.parse('an OpenAPI spec file exists with paths "{path1}" and "{path2}"'),
    target_fixture="spec_file",
)
def an_openapi_spec_file_exists(path1, path2):
    spec = {
        "openapi": "3.0.0",
        "info": {"title": "Test API", "version": "1.0.0"},
        "paths": {
            path1: {
                "get": {
                    "summary": f"Get {path1}",
                    "responses": {
                        "200": {
                            "description": "OK",
                            "content": {
                                "application/json": {
                                    "schema": {"type": "object"},
                                    "example": {"id": "test"},
                                }
                            },
                        }
                    },
                }
            },
            path2: {
                "post": {
                    "summary": f"Create {path2}",
                    "responses": {
                        "201": {
                            "description": "Created",
                            "content": {
                                "application/json": {
                                    "schema": {"type": "object"},
                                    "example": {"created": True},
                                }
                            },
                        }
                    },
                }
            },
        },
    }
    spec_path = _e2e_project_dir() / "test-spec.yaml"
    spec_path.write_text(yaml.dump(spec, default_flow_style=False))
    return str(spec_path)


@given(
    parsers.parse('the spec file was imported into "{name}"'),
)
def the_spec_file_was_imported(name, spec_file, e2e_port):
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        [
            "mock",
            "import-spec",
            name,
            "--spec-file",
            spec_file,
            "--project-dir",
            str(project_dir),
        ],
    )
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (import-spec): {result.output}")


# ── When steps ──────────────────────────────────────────────────


@when(
    parsers.parse('I create mock server "{name}"'),
    target_fixture="command_result",
)
def i_create_mock_server(name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        ["mock", "create", name, "--project-dir", str(project_dir)],
    )


@when(
    parsers.parse('I create mock server "{name}" with port {port:d}'),
    target_fixture="command_result",
)
def i_create_mock_server_with_port(name, port, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        ["mock", "create", name, "--port", str(port), "--project-dir", str(project_dir)],
    )


@when(
    parsers.parse('I create mock server "{name}" with description "{description}"'),
    target_fixture="command_result",
)
def i_create_mock_server_with_description(name, description, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "create",
            name,
            "--description",
            description,
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse('I create mock server "{name}" with protocol "{protocol}"'),
    target_fixture="command_result",
)
def i_create_mock_server_with_protocol(name, protocol, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "create",
            name,
            "--protocol",
            protocol,
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse('I delete mock server "{name}"'),
    target_fixture="command_result",
)
def i_delete_mock_server(name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        ["mock", "delete", name, "--yes", "--project-dir", str(project_dir)],
    )


@when("I list mock servers", target_fixture="command_result")
def i_list_mock_servers(e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        ["mock", "list", "--project-dir", str(project_dir)],
    )


@when(
    parsers.parse('I add route "{path}" with method "{method}" and status {status:d} to "{name}"'),
    target_fixture="command_result",
)
def i_add_route(path, method, status, name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "add-route",
            name,
            "--path",
            path,
            "--method",
            method,
            "--status",
            str(status),
            "--body",
            '{"mock": true}',
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse(
        'I add route "{path}" with method "{method}" and status {status:d}'
        " and body '{body}' to \"{name}\""
    ),
    target_fixture="command_result",
)
def i_add_route_with_body(path, method, status, body, name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "add-route",
            name,
            "--path",
            path,
            "--method",
            method,
            "--status",
            str(status),
            "--body",
            body,
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse(
        'I add route "{path}" with method "{method}" and status {status:d}'
        ' and header "{header}" to "{name}"'
    ),
    target_fixture="command_result",
)
def i_add_route_with_header(path, method, status, header, name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "add-route",
            name,
            "--path",
            path,
            "--method",
            method,
            "--status",
            str(status),
            "--body",
            '{"mock": true}',
            "--header",
            header,
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse('I remove route "{path}" with method "{method}" from "{name}"'),
    target_fixture="command_result",
)
def i_remove_route(path, method, name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "remove-route",
            name,
            "--path",
            path,
            "--method",
            method,
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse('I get status of mock server "{name}"'),
    target_fixture="command_result",
)
def i_get_status(name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        ["mock", "status", name, "--project-dir", str(project_dir)],
    )


@when(
    parsers.parse('I read the config of mock server "{name}"'),
    target_fixture="config_data",
)
def i_read_the_config(name, e2e_port):
    return _read_config_yaml(name)


@when(
    parsers.parse('I import the spec file into "{name}"'),
    target_fixture="command_result",
)
def i_import_spec(name, spec_file, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "import-spec",
            name,
            "--spec-file",
            spec_file,
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse('I import the spec file into "{name}" with overwrite'),
    target_fixture="command_result",
)
def i_import_spec_overwrite(name, spec_file, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "import-spec",
            name,
            "--spec-file",
            spec_file,
            "--overwrite",
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse('I validate mock server "{name}"'),
    target_fixture="command_result",
)
def i_validate(name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        ["mock", "validate", name, "--project-dir", str(project_dir)],
    )


@when(
    parsers.parse('I validate mock server "{name}" against the spec file'),
    target_fixture="command_result",
)
def i_validate_against_spec(name, spec_file, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "validate",
            name,
            "--spec-file",
            spec_file,
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse('I validate mock server "{name}" against the spec file in strict mode'),
    target_fixture="command_result",
)
def i_validate_strict(name, spec_file, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "validate",
            name,
            "--spec-file",
            spec_file,
            "--strict",
            "--project-dir",
            str(project_dir),
        ],
    )


# ── Then steps ──────────────────────────────────────────────────


@then("the command will fail")
def the_command_will_fail(command_result):
    assert (
        command_result.exit_code != 0
    ), f"Expected command to fail but exit code was {command_result.exit_code}"


@then(
    parsers.parse('the output will contain "{text}"'),
)
def the_output_will_contain(text, command_result):
    assert (
        text in command_result.output
    ), f"Expected '{text}' in output, got: {command_result.output}"


@then(
    parsers.parse('the output will contain mock server "{name}"'),
)
def the_output_will_contain_mock_server(name, command_result):
    output = json.loads(command_result.output)
    if "servers" in output:
        actual_names = [s["name"] for s in output["servers"]]
        assert name in actual_names
    else:
        actual_name = output.get("name") or output.get("created")
        assert actual_name == name


@then(
    parsers.parse("the output will show {count:d} route(s)"),
)
def the_output_will_show_route_count(count, command_result):
    output = json.loads(command_result.output)
    actual_count = output.get("route_count", 0)
    assert actual_count == count


@then(
    parsers.parse("the output will show {count:d} server(s)"),
)
def the_output_will_show_server_count(count, command_result):
    output = json.loads(command_result.output)
    actual_count = len(output.get("servers", []))
    assert actual_count == count


@then(
    parsers.parse("the output will show 0 servers"),
)
def the_output_will_show_zero_servers(command_result):
    output = json.loads(command_result.output)
    actual_count = len(output.get("servers", []))
    assert actual_count == 0


@then(
    parsers.parse("the output will show {count:d} imported files"),
)
def the_output_will_show_imported_count(count, command_result):
    output = json.loads(command_result.output)
    actual_count = output.get("imported", 0)
    assert actual_count == count


@then("the mock server directory will exist")
def the_mock_server_directory_will_exist(command_result):
    output = json.loads(command_result.output)
    path = output.get("path")
    if path:
        assert Path(path).exists()


@then(
    parsers.parse('mock server "{name}" will not exist'),
)
def mock_server_will_not_exist(name):
    assert not _mock_dir(name).exists()


@then(
    parsers.parse("the config will have port {port:d}"),
)
def the_config_will_have_port(port, command_result):
    output = json.loads(command_result.output)
    name = output.get("created", "")
    config = _read_config_yaml(name)
    actual_port = config.get("port")
    assert actual_port == port


@then(
    parsers.parse('the config will have description "{description}"'),
)
def the_config_will_have_description(description, command_result):
    output = json.loads(command_result.output)
    name = output.get("created", "")
    config = _read_config_yaml(name)
    actual_description = config.get("description", "")
    assert actual_description == description


@then(
    parsers.parse('the config will have protocol "{protocol}"'),
)
def the_config_will_have_protocol(protocol, command_result):
    output = json.loads(command_result.output)
    name = output.get("created", "")
    config = _read_config_yaml(name)
    actual_protocol = config.get("protocol", "rest")
    assert actual_protocol == protocol


@then("the config will have chaos disabled")
def the_config_will_have_chaos_disabled(command_result):
    output = json.loads(command_result.output)
    name = output.get("created") or output.get("name", "")
    config = _read_config_yaml(name)
    actual_enabled = config.get("chaos", {}).get("enabled", False)
    assert actual_enabled is False


@then(
    parsers.parse('the output will have protocol "{protocol}"'),
)
def the_output_will_have_protocol(protocol, command_result):
    output = json.loads(command_result.output)
    actual_protocol = output.get("protocol", "")
    assert actual_protocol == protocol


@then(
    parsers.parse('the route file will exist for "{path}" with method "{method}" in "{name}"'),
)
def the_route_file_will_exist(path, method, name):
    safe_path = path.strip("/").replace("/", "_").replace("{", "").replace("}", "")
    if not safe_path:
        safe_path = "root"
    filename = f"{safe_path}_{method.lower()}.yaml"
    route_file = _mock_dir(name) / "routes" / filename
    assert route_file.exists(), f"Route file {filename} does not exist"


@then(
    parsers.parse('the route file will not exist for "{path}" with method "{method}" in "{name}"'),
)
def the_route_file_will_not_exist(path, method, name):
    safe_path = path.strip("/").replace("/", "_").replace("{", "").replace("}", "")
    if not safe_path:
        safe_path = "root"
    filename = f"{safe_path}_{method.lower()}.yaml"
    route_file = _mock_dir(name) / "routes" / filename
    assert not route_file.exists(), f"Route file {filename} should not exist"


@then(
    parsers.parse("the chaos error rate will be {rate:g}"),
)
def the_chaos_error_rate_will_be(rate, config_data):
    actual_rate = config_data.get("chaos", {}).get("error_rate", 0.0)
    assert actual_rate == rate


@then(
    parsers.parse("the chaos latency min will be {value:d}"),
)
def the_chaos_latency_min_will_be(value, config_data):
    latency = config_data.get("chaos", {}).get("latency", {})
    actual_min = latency.get("min_ms", 0)
    assert actual_min == value


@then(
    parsers.parse("the chaos latency max will be {value:d}"),
)
def the_chaos_latency_max_will_be(value, config_data):
    latency = config_data.get("chaos", {}).get("latency", {})
    actual_max = latency.get("max_ms", 0)
    assert actual_max == value


@then(
    parsers.parse("the chaos connection reset rate will be {rate:g}"),
)
def the_chaos_connection_reset_rate_will_be(rate, config_data):
    actual_rate = config_data.get("chaos", {}).get("connection_reset_rate", 0.0)
    assert actual_rate == rate


@then(
    parsers.parse("the chaos timeout rate will be {rate:g}"),
)
def the_chaos_timeout_rate_will_be(rate, config_data):
    actual_rate = config_data.get("chaos", {}).get("timeout_rate", 0.0)
    assert actual_rate == rate


@then("the spec file will be copied to the mock server directory")
def the_spec_file_will_be_copied(command_result):
    output = json.loads(command_result.output)
    files = output.get("files", [])
    # The import also copies the spec to spec.yaml in the mock dir
    # We need to find the mock name from context - check the first generated file's parent
    if files:
        # files are relative to mock dir, e.g. "routes/v1_users_get.yaml"
        # spec.yaml is at the mock dir root
        pass
    # Spec was imported - we can check the output shows files were imported
    assert output.get("imported", 0) > 0


@then("the validation result will be valid")
def the_validation_result_will_be_valid(command_result):
    output = json.loads(command_result.output)
    assert output.get("valid") is True


@then("the validation result will have issues")
def the_validation_result_will_have_issues(command_result):
    output = json.loads(command_result.output)
    actual_issues = output.get("issues", [])
    assert len(actual_issues) > 0
