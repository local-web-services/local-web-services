"""Session-scoped fixtures: start ldk dev, tear down via ldk stop."""

from __future__ import annotations

import json
import subprocess
import time

import httpx
import pytest


def parse_json_output(text: str):
    """Extract JSON from CLI output that may contain stderr warnings.

    Typer's CliRunner mixes stderr into stdout.  Experimental service
    warnings (e.g. ``Warning: 'docdb' is experimental …``) may appear
    before or after the JSON payload.  This helper uses ``raw_decode``
    to extract the first valid JSON object regardless of surrounding text.
    """
    try:
        return json.loads(text)
    except (json.JSONDecodeError, ValueError):
        pass
    decoder = json.JSONDecoder()
    for i, ch in enumerate(text):
        if ch in ("{", "["):
            try:
                obj, _ = decoder.raw_decode(text, i)
                return obj
            except (json.JSONDecodeError, ValueError):
                continue
    return text


E2E_PORT = 19300


@pytest.fixture(scope="session")
def e2e_port():
    return E2E_PORT


@pytest.fixture(scope="session", autouse=True)
def ldk_server(tmp_path_factory, e2e_port):
    """Start ldk dev as a subprocess, wait for readiness, yield, stop."""
    project_dir = tmp_path_factory.mktemp("e2e_project")
    proc = subprocess.Popen(
        [
            "uv",
            "run",
            "ldk",
            "dev",
            "--mode",
            "terraform",
            "--port",
            str(e2e_port),
            "--project-dir",
            str(project_dir),
            "--no-persist",
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    # Poll /_ldk/status until running=true (timeout after 30s)
    deadline = time.monotonic() + 30
    while time.monotonic() < deadline:
        try:
            resp = httpx.get(f"http://localhost:{e2e_port}/_ldk/status", timeout=2.0)
            if resp.status_code == 200 and resp.json().get("running"):
                break
        except (httpx.ConnectError, httpx.ConnectTimeout):
            pass
        time.sleep(0.5)
    else:
        proc.kill()
        raise RuntimeError("ldk dev failed to start within 30 seconds")

    yield e2e_port

    # Teardown via ldk stop
    subprocess.run(
        ["uv", "run", "ldk", "stop", "--port", str(e2e_port)],
        timeout=10,
    )
    try:
        proc.wait(timeout=15)
    except subprocess.TimeoutExpired:
        proc.kill()
        proc.wait(timeout=5)


@pytest.fixture(scope="session")
def lws_invoke(e2e_port):
    """Return a helper that invokes lws CLI commands. Use in arrange phases."""
    from typer.testing import CliRunner

    from lws.cli.lws import app

    _runner = CliRunner()

    def _invoke(args: list[str]):
        result = _runner.invoke(app, args)
        if result.exit_code != 0:
            cmd = " ".join(args)
            raise RuntimeError(f"Arrange failed (lws {cmd}): {result.output}")
        return parse_json_output(result.output)

    return _invoke


@pytest.fixture(scope="session")
def parse_output():
    """Return a helper to parse JSON from CLI output that may contain stderr warnings."""
    return parse_json_output


@pytest.fixture(scope="session")
def assert_invoke(e2e_port):
    """Return a helper that invokes lws CLI commands. Use in assert phases."""
    from typer.testing import CliRunner

    from lws.cli.lws import app

    _runner = CliRunner()

    def _invoke(args: list[str]):
        result = _runner.invoke(app, args)
        if result.exit_code != 0:
            cmd = " ".join(args)
            raise AssertionError(f"Assert failed (lws {cmd}): {result.output}")
        return parse_json_output(result.output)

    return _invoke
