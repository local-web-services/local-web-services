"""Session-scoped fixtures: start ldk dev in-process, tear down gracefully."""

from __future__ import annotations

import json
import threading
import time
import urllib.error
import urllib.request

import pytest
from pytest_bdd import then


def parse_json_output(text: str):
    """Extract JSON from CLI output that may contain stderr warnings.

    Typer's CliRunner mixes stderr into stdout.  Experimental service
    warnings (e.g. ``Warning: 'docdb' is experimental …``) and in-process
    server log lines may appear before or after the JSON payload.  This
    helper uses ``raw_decode`` to find JSON, preferring ``{`` objects over
    ``[`` arrays to avoid matching fragments like ``lambda_funcs=[]`` in
    log lines.
    """
    try:
        return json.loads(text)
    except (json.JSONDecodeError, ValueError):
        pass
    decoder = json.JSONDecoder()
    # First pass: look for JSON objects (most CLI commands output dicts)
    for i, ch in enumerate(text):
        if ch == "{":
            try:
                obj, _ = decoder.raw_decode(text, i)
                return obj
            except (json.JSONDecodeError, ValueError):
                continue
    # Second pass: fall back to JSON arrays
    for i, ch in enumerate(text):
        if ch == "[":
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
    """Start ldk dev in-process on a background thread, wait for readiness."""
    import asyncio

    from lws.cli.ldk import _run_dev

    project_dir = tmp_path_factory.mktemp("e2e_project")
    error_holder: list[Exception] = []

    def _run():
        try:
            asyncio.run(
                _run_dev(
                    project_dir,
                    e2e_port,
                    no_persist=True,
                    force_synth=False,
                    log_level_override=None,
                    mode_override="terraform",
                )
            )
        except Exception as exc:
            error_holder.append(exc)

    thread = threading.Thread(target=_run, daemon=True)
    thread.start()

    status_url = f"http://localhost:{e2e_port}/_ldk/status"
    deadline = time.monotonic() + 60
    last_error = None
    while time.monotonic() < deadline:
        if error_holder:
            raise RuntimeError(f"ldk dev failed to start: {error_holder[0]}") from error_holder[0]
        try:
            with urllib.request.urlopen(status_url, timeout=2) as resp:
                data = json.loads(resp.read())
                if data.get("running"):
                    break
        except Exception as exc:
            last_error = exc
        time.sleep(0.5)
    else:
        raise RuntimeError(f"ldk dev failed to start within 60 seconds. Last error: {last_error}")

    yield e2e_port

    # Teardown via shutdown endpoint
    try:
        shutdown_url = f"http://localhost:{e2e_port}/_ldk/shutdown"
        req = urllib.request.Request(shutdown_url, method="POST", data=b"")
        urllib.request.urlopen(req, timeout=5)
    except Exception:
        pass
    thread.join(timeout=30)

    # Safety net: remove any leftover lws-{service}-e2e-* containers
    import subprocess

    try:
        result = subprocess.run(
            ["docker", "ps", "-a", "-q", "--filter", "name=^lws-.*-e2e-"],
            capture_output=True,
            text=True,
            timeout=10,
        )
        container_ids = result.stdout.strip()
        if container_ids:
            subprocess.run(
                ["docker", "rm", "-f"] + container_ids.split(),
                capture_output=True,
                timeout=30,
            )
    except (FileNotFoundError, subprocess.TimeoutExpired):
        pass


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


# ── Shared BDD steps ────────────────────────────────────────────────


@then("the command will succeed")
def the_command_will_succeed(command_result):
    assert command_result.exit_code == 0, command_result.output
