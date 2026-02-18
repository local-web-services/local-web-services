"""``lws aws-mock`` sub-commands for managing AWS operation mocks."""

from __future__ import annotations

import asyncio
import json
import shutil
from pathlib import Path
from typing import Any

import typer

from lws.cli.services.client import exit_with_error, output_json

app = typer.Typer(help="AWS operation mock commands")


def _mocks_dir(project_dir: Path) -> Path:
    return project_dir / ".lws" / "mocks"


@app.command("create")
def create(
    name: str = typer.Argument(..., help="Mock name"),
    service: str = typer.Option(..., "--service", "-s", help="AWS service (e.g. s3, dynamodb)"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Create a new AWS operation mock."""
    from lws.providers._shared.aws_mock_dsl import (  # pylint: disable=import-outside-toplevel
        generate_aws_mock_config_yaml,
    )

    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if mock_dir.exists():
        exit_with_error(f"AWS mock '{name}' already exists at {mock_dir}")

    mock_dir.mkdir(parents=True)
    (mock_dir / "operations").mkdir()

    config_content = generate_aws_mock_config_yaml(name, service)
    (mock_dir / "config.yaml").write_text(config_content)

    output_json({"created": name, "service": service, "path": str(mock_dir)})


@app.command("delete")
def delete(
    name: str = typer.Argument(..., help="Mock name"),
    yes: bool = typer.Option(False, "--yes", "-y", help="Skip confirmation"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Delete an AWS operation mock."""
    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"AWS mock '{name}' not found")

    if not yes and not typer.confirm(f"Delete AWS mock '{name}'?"):
        typer.echo("Aborted.")
        return

    shutil.rmtree(mock_dir)
    output_json({"deleted": name})


@app.command("list")
def list_mocks(
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """List all AWS operation mocks."""
    project_dir = project_dir.resolve()
    mocks_root = _mocks_dir(project_dir)
    found = _scan_aws_mocks(mocks_root)
    output_json({"mocks": found})


def _scan_aws_mocks(mocks_root: Path) -> list[dict[str, Any]]:
    """Scan *mocks_root* and return summaries for AWS mocks (those with ``service``)."""
    results: list[dict[str, Any]] = []
    if not mocks_root.exists():
        return results
    for child in sorted(mocks_root.iterdir()):
        if child.is_dir() and (child / "config.yaml").exists():
            summary = _read_mock_summary(child)
            if summary is not None:
                results.append(summary)
    return results


def _read_mock_summary(mock_dir: Path) -> dict[str, Any] | None:
    """Read a summary of an AWS mock. Returns None if not an AWS mock."""
    import yaml  # pylint: disable=import-outside-toplevel

    config_path = mock_dir / "config.yaml"
    raw = yaml.safe_load(config_path.read_text()) or {}
    service = raw.get("service")
    if not service:
        return None
    ops_dir = mock_dir / "operations"
    op_count = len(list(ops_dir.glob("*.yaml"))) if ops_dir.exists() else 0
    return {
        "name": raw.get("name", mock_dir.name),
        "service": service,
        "enabled": raw.get("enabled", True),
        "operation_count": op_count,
    }


@app.command("add-operation")
def add_operation(
    name: str = typer.Argument(..., help="Mock name"),
    operation: str = typer.Option(
        ..., "--operation", "-o", help="Operation name (e.g. get-object)"
    ),
    op_status: int = typer.Option(200, "--status", help="Response status code"),
    body: str = typer.Option(None, "--body", help="Response body (JSON string)"),
    content_type: str = typer.Option(None, "--content-type", help="Response content type"),
    match_header: list[str] = typer.Option(None, "--match-header", help="Match header (Key=Value)"),
    body_string: str = typer.Option(None, "--body-string", help="S3: inline body content"),
    body_file: str = typer.Option(None, "--body-file", help="S3: body from file path"),
    item: str = typer.Option(None, "--item", help="DynamoDB: simplified item JSON"),
    param_name: str = typer.Option(None, "--param-name", help="SSM: parameter name"),
    param_value: str = typer.Option(None, "--param-value", help="SSM: parameter value"),
    secret_string: str = typer.Option(
        None, "--secret-string", help="SecretsManager: secret string"
    ),
    secret_name: str = typer.Option(None, "--secret-name", help="SecretsManager: secret name"),
    secret_file: str = typer.Option(None, "--secret-file", help="SecretsManager: secret from file"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Add an operation rule to an AWS mock."""
    from lws.providers._shared.aws_mock_dsl import (  # pylint: disable=import-outside-toplevel
        generate_operation_yaml,
    )

    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"AWS mock '{name}' not found")

    ops_dir = mock_dir / "operations"
    ops_dir.mkdir(exist_ok=True)

    match_headers = _parse_match_headers(match_header)
    helpers = _build_helpers(
        operation,
        body_string,
        body_file,
        item,
        param_name,
        param_value,
        secret_string,
        secret_name,
        secret_file,
    )

    parsed_body = _parse_body(body)

    op_yaml = generate_operation_yaml(
        operation,
        status=op_status,
        body=parsed_body,
        content_type=content_type,
        match_headers=match_headers or None,
        helpers=helpers or None,
    )

    safe_op = operation.replace("-", "_")
    filename = f"{safe_op}.yaml"
    op_file = ops_dir / filename

    if op_file.exists():
        _append_to_operation_file(op_file, op_yaml)
    else:
        op_file.write_text(op_yaml)

    output_json({"added": operation, "file": str(op_file)})


def _parse_match_headers(match_header: list[str] | None) -> dict[str, str]:
    headers: dict[str, str] = {}
    if match_header:
        for h in match_header:
            if "=" in h:
                key, val = h.split("=", 1)
                headers[key.strip()] = val.strip()
    return headers


def _parse_body(body: str | None) -> Any:
    if body is None:
        return None
    try:
        return json.loads(body)
    except json.JSONDecodeError:
        return body


def _build_helpers(
    operation: str,  # noqa: ARG001  # pylint: disable=unused-argument
    body_string: str | None,
    body_file: str | None,
    item: str | None,
    param_name: str | None,
    param_value: str | None,
    secret_string: str | None,
    secret_name: str | None,
    secret_file: str | None,
) -> dict[str, Any] | None:
    """Build helpers dict from CLI flags."""
    helpers: dict[str, Any] = {}
    if body_string is not None:
        helpers["body_string"] = body_string
    if body_file is not None:
        helpers["body_file"] = body_file
    if item is not None:
        helpers["item"] = json.loads(item)
    if param_name is not None:
        helpers["name"] = param_name
    if param_value is not None:
        helpers["value"] = param_value
    if secret_string is not None:
        helpers["secret_string"] = secret_string
    if secret_name is not None:
        helpers["name"] = secret_name
    if secret_file is not None:
        helpers["secret_file"] = secret_file
    return helpers or None


def _append_to_operation_file(op_file: Path, new_yaml: str) -> None:
    """Append new operations to an existing operation file."""
    import yaml  # pylint: disable=import-outside-toplevel

    existing = yaml.safe_load(op_file.read_text()) or {}
    new_data = yaml.safe_load(new_yaml) or {}
    existing_ops = existing.get("operations", [])
    new_ops = new_data.get("operations", [])
    existing_ops.extend(new_ops)
    existing["operations"] = existing_ops
    op_file.write_text(yaml.dump(existing, default_flow_style=False, sort_keys=False))


@app.command("remove-operation")
def remove_operation(
    name: str = typer.Argument(..., help="Mock name"),
    operation: str = typer.Option(..., "--operation", "-o", help="Operation name to remove"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Remove an operation from an AWS mock."""
    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"AWS mock '{name}' not found")

    safe_op = operation.replace("-", "_")
    filename = f"{safe_op}.yaml"
    op_file = mock_dir / "operations" / filename

    if not op_file.exists():
        exit_with_error(f"Operation file not found: {filename}")

    op_file.unlink()
    output_json({"removed": operation})


@app.command("set-rules")
def set_rules(
    service: str = typer.Argument(..., help="Service name"),
    operation: str = typer.Option(..., "--operation", "-o", help="Operation name"),
    op_status: int = typer.Option(200, "--status", help="Response status"),
    body: str = typer.Option(None, "--body", help="Response body"),
    content_type: str = typer.Option("application/json", "--content-type", help="Content type"),
    match_header: list[str] = typer.Option(
        None, "--match-header", help="Header filter (Key=Value)"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Configure mock rules at runtime via the management API."""
    rule: dict[str, Any] = {
        "operation": operation,
        "response": {
            "status": op_status,
            "content_type": content_type,
        },
    }
    if body is not None:
        rule["response"]["body"] = _parse_body(body)
    if match_header:
        rule["match"] = {"headers": _parse_match_headers(match_header)}
    payload = {service: {"enabled": True, "rules": [rule]}}
    asyncio.run(_ldk_api_call(port, "POST", "aws-mock", payload))


@app.command("enable")
def enable(
    service: str = typer.Argument(..., help="Service name (e.g. s3, dynamodb)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Enable an AWS mock at runtime."""
    asyncio.run(_ldk_api_call(port, "POST", "aws-mock", {service: {"enabled": True}}))


@app.command("disable")
def disable(
    service: str = typer.Argument(..., help="Service name (e.g. s3, dynamodb)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Disable an AWS mock at runtime."""
    asyncio.run(_ldk_api_call(port, "POST", "aws-mock", {service: {"enabled": False}}))


@app.command("status")
def status(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Show AWS mock status for all services."""
    asyncio.run(_ldk_api_call(port, "GET", "aws-mock"))


async def _ldk_api_call(
    port: int,
    method: str,
    path: str,
    json_body: dict[str, Any] | None = None,
) -> None:
    """Call the LDK management API and print the response."""
    import httpx  # pylint: disable=import-outside-toplevel

    url = f"http://localhost:{port}/_ldk/{path}"
    try:
        async with httpx.AsyncClient(timeout=5.0) as client:
            if method == "GET":
                resp = await client.get(url)
            else:
                resp = await client.post(url, json=json_body or {})
            resp.raise_for_status()
            output_json(resp.json())
    except (httpx.ConnectError, httpx.ConnectTimeout):
        exit_with_error(f"Cannot reach ldk dev on port {port}. Is it running?")
