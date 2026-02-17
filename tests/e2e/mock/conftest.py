"""Shared fixtures for mock server E2E tests."""

from __future__ import annotations

import json
import shutil
from pathlib import Path

import pytest
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


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a mock server "{name}" was created'),
    target_fixture="given_mock",
)
def a_mock_server_was_created(name, e2e_port):
    project_dir = _e2e_project_dir()
    result = runner.invoke(
        app,
        [
            "mock",
            "create",
            name,
            "--project-dir",
            str(project_dir),
        ],
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


@when(
    parsers.parse('I create mock server "{name}"'),
    target_fixture="command_result",
)
def i_create_mock_server(name, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "create",
            name,
            "--project-dir",
            str(project_dir),
        ],
    )


@when(
    parsers.parse('I create mock server "{name}" with port {port:d}'),
    target_fixture="command_result",
)
def i_create_mock_server_with_port(name, port, e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "create",
            name,
            "--port",
            str(port),
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
        [
            "mock",
            "delete",
            name,
            "--yes",
            "--project-dir",
            str(project_dir),
        ],
    )


@when("I list mock servers", target_fixture="command_result")
def i_list_mock_servers(e2e_port):
    project_dir = _e2e_project_dir()
    return runner.invoke(
        app,
        [
            "mock",
            "list",
            "--project-dir",
            str(project_dir),
        ],
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
        [
            "mock",
            "status",
            name,
            "--project-dir",
            str(project_dir),
        ],
    )


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
    project_dir = _e2e_project_dir()
    mock_dir = project_dir / ".lws" / "mocks" / name
    assert not mock_dir.exists()
