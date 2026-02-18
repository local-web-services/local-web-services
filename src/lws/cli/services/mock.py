"""``lws mock`` sub-commands for managing mock servers."""

from __future__ import annotations

import asyncio
import json
import shutil
from pathlib import Path
from typing import Any

import typer

from lws.cli.services.client import LwsClient, build_chaos_body, exit_with_error, output_json

app = typer.Typer(help="Mock server commands")


def _mocks_dir(project_dir: Path) -> Path:
    """Return the .lws/mocks directory path."""
    return project_dir / ".lws" / "mocks"


@app.command("create")
def create(
    name: str = typer.Argument(..., help="Mock server name"),
    port: int = typer.Option(None, "--port", help="Fixed port number"),
    protocol: str = typer.Option("rest", "--protocol", help="Protocol: rest, graphql, or grpc"),
    description: str = typer.Option("", "--description", help="Server description"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Create a new mock server configuration."""
    from lws.providers.mockserver.dsl import (  # pylint: disable=import-outside-toplevel
        generate_config_yaml,
    )

    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if mock_dir.exists():
        exit_with_error(f"Mock server '{name}' already exists at {mock_dir}")

    mock_dir.mkdir(parents=True)
    (mock_dir / "routes").mkdir()

    config_content = generate_config_yaml(
        name, port=port, protocol=protocol, description=description
    )
    (mock_dir / "config.yaml").write_text(config_content)

    output_json({"created": name, "path": str(mock_dir)})


@app.command("delete")
def delete(
    name: str = typer.Argument(..., help="Mock server name"),
    yes: bool = typer.Option(False, "--yes", "-y", help="Skip confirmation"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Delete a mock server configuration."""
    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"Mock server '{name}' not found")

    if not yes:
        confirm = typer.confirm(f"Delete mock server '{name}'?")
        if not confirm:
            typer.echo("Aborted.")
            return

    shutil.rmtree(mock_dir)
    output_json({"deleted": name})


@app.command("list")
def list_servers(  # pylint: disable=unused-argument
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """List all mock servers."""
    project_dir = project_dir.resolve()
    mocks = _mocks_dir(project_dir)
    servers = []
    if mocks.exists():
        for child in sorted(mocks.iterdir()):
            if child.is_dir() and (child / "config.yaml").exists():
                servers.append(_read_server_summary(child))
    output_json({"servers": servers})


def _read_server_summary(mock_dir: Path) -> dict[str, Any]:
    """Read a summary of a mock server from its directory."""
    import yaml  # pylint: disable=import-outside-toplevel

    config_path = mock_dir / "config.yaml"
    raw = yaml.safe_load(config_path.read_text()) or {}
    routes_dir = mock_dir / "routes"
    route_count = len(list(routes_dir.glob("*.yaml"))) if routes_dir.exists() else 0
    return {
        "name": raw.get("name", mock_dir.name),
        "protocol": raw.get("protocol", "rest"),
        "port": raw.get("port"),
        "route_count": route_count,
        "description": raw.get("description", ""),
    }


@app.command("status")
def status(  # pylint: disable=unused-argument
    name: str = typer.Argument(..., help="Mock server name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Show detailed status of a mock server."""
    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"Mock server '{name}' not found")
    summary = _read_server_summary(mock_dir)
    output_json(summary)


@app.command("add-route")
def add_route(
    name: str = typer.Argument(..., help="Mock server name"),
    path: str = typer.Option(..., "--path", help="Route path (e.g. /v1/users)"),
    method: str = typer.Option("GET", "--method", help="HTTP method"),
    route_status: int = typer.Option(200, "--status", help="Response status code"),
    body: str = typer.Option(None, "--body", help="Response body (JSON string)"),
    header: list[str] = typer.Option(None, "--header", help="Response header (Key:Value)"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Add a route to an existing mock server."""
    from lws.providers.mockserver.dsl import (  # pylint: disable=import-outside-toplevel
        generate_route_yaml,
    )

    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"Mock server '{name}' not found")

    routes_dir = mock_dir / "routes"
    routes_dir.mkdir(exist_ok=True)

    parsed_body = None
    if body:
        try:
            parsed_body = json.loads(body)
        except json.JSONDecodeError:
            parsed_body = body

    headers: dict[str, str] = {}
    if header:
        for h in header:
            if ":" in h:
                key, val = h.split(":", 1)
                headers[key.strip()] = val.strip()

    route_yaml = generate_route_yaml(
        path, method=method, status=route_status, body=parsed_body, headers=headers or None
    )

    safe_path = path.strip("/").replace("/", "_").replace("{", "").replace("}", "")
    if not safe_path:
        safe_path = "root"
    filename = f"{safe_path}_{method.lower()}.yaml"
    route_file = routes_dir / filename
    route_file.write_text(route_yaml)

    output_json({"added": path, "method": method.upper(), "file": str(route_file)})


@app.command("remove-route")
def remove_route(
    name: str = typer.Argument(..., help="Mock server name"),
    path: str = typer.Option(..., "--path", help="Route path to remove"),
    method: str = typer.Option("GET", "--method", help="HTTP method"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Remove a route from a mock server."""
    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"Mock server '{name}' not found")

    routes_dir = mock_dir / "routes"
    safe_path = path.strip("/").replace("/", "_").replace("{", "").replace("}", "")
    if not safe_path:
        safe_path = "root"
    filename = f"{safe_path}_{method.lower()}.yaml"
    route_file = routes_dir / filename

    if not route_file.exists():
        exit_with_error(f"Route file not found: {filename}")

    route_file.unlink()
    output_json({"removed": path, "method": method.upper()})


@app.command("import-spec")
def import_spec(
    name: str = typer.Argument(..., help="Mock server name"),
    spec_file: Path = typer.Option(..., "--spec-file", help="Path to OpenAPI spec file"),
    overwrite: bool = typer.Option(False, "--overwrite", help="Overwrite existing routes"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Import an OpenAPI spec to generate mock routes."""
    from lws.providers.mockserver.openapi_import import (  # pylint: disable=import-outside-toplevel
        import_openapi_spec,
    )

    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"Mock server '{name}' not found")

    spec_file = spec_file.resolve()
    if not spec_file.exists():
        exit_with_error(f"Spec file not found: {spec_file}")

    generated = import_openapi_spec(spec_file, mock_dir, overwrite=overwrite)
    output_json({"imported": len(generated), "files": generated})


@app.command("validate")
def validate(
    name: str = typer.Argument(..., help="Mock server name"),
    spec_file: Path = typer.Option(None, "--spec-file", help="Path to OpenAPI spec file"),
    strict: bool = typer.Option(False, "--strict", help="Treat warnings as errors"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Validate mock definitions against an OpenAPI spec."""
    from lws.providers.mockserver.dsl import (  # pylint: disable=import-outside-toplevel
        load_mock_server,
    )
    from lws.providers.mockserver.validator import (  # pylint: disable=import-outside-toplevel
        validate_against_spec,
    )

    project_dir = project_dir.resolve()
    mock_dir = _mocks_dir(project_dir) / name
    if not mock_dir.exists():
        exit_with_error(f"Mock server '{name}' not found")

    if spec_file is None:
        spec_file = mock_dir / "spec.yaml"
    else:
        spec_file = spec_file.resolve()

    if not spec_file.exists():
        exit_with_error(f"Spec file not found: {spec_file}")

    config = load_mock_server(mock_dir)
    issues = validate_against_spec(config, spec_file)

    result = {
        "valid": all(i.level != "ERROR" for i in issues),
        "issues": [
            {"level": i.level, "message": i.message, "path": i.path, "method": i.method}
            for i in issues
        ],
    }
    if strict and issues:
        result["valid"] = False

    output_json(result)
    if not result["valid"]:
        raise SystemExit(1)


@app.command("chaos")
def chaos(
    name: str = typer.Argument(..., help="Mock server name"),
    action: str = typer.Argument(..., help="enable or disable"),
    error_rate: float = typer.Option(None, "--error-rate", help="Error injection probability"),
    latency_min: int = typer.Option(None, "--latency-min", help="Min latency ms"),
    latency_max: int = typer.Option(None, "--latency-max", help="Max latency ms"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Toggle chaos engineering on a running mock server."""
    asyncio.run(_chaos(name, action, error_rate, latency_min, latency_max, port))


async def _chaos(
    name: str,
    action: str,
    error_rate: float | None,
    latency_min: int | None,
    latency_max: int | None,
    port: int,
) -> None:
    client = LwsClient(port=port)
    try:
        meta = await client.discover()
        services = meta.get("services", {})
        mock_info = services.get("mockserver", {})
        servers = mock_info.get("resources", [])
        server = next((s for s in servers if s.get("name") == name), None)
        if not server:
            exit_with_error(f"Mock server '{name}' not found in running instance")
        mock_port = server.get("port")
    except Exception as exc:
        exit_with_error(str(exc))

    body = build_chaos_body(error_rate=error_rate, latency_min=latency_min, latency_max=latency_max)
    body["enabled"] = action == "enable"

    try:
        async with __import__("httpx").AsyncClient() as http:
            resp = await http.post(
                f"http://localhost:{mock_port}/_mock/chaos", json=body, timeout=5.0
            )
            output_json(resp.json())
    except Exception as exc:
        exit_with_error(str(exc))


@app.command("invoke")
def invoke(
    name: str = typer.Argument(..., help="Mock server name"),
    path: str = typer.Option("/", "--path", help="Request path"),
    method: str = typer.Option("GET", "--method", help="HTTP method"),
    body: str = typer.Option(None, "--body", help="Request body (JSON)"),
    header: list[str] = typer.Option(None, "--header", help="Request header (Key:Value)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Send a test request to a running mock server."""
    asyncio.run(_invoke(name, path, method, body, header, port))


async def _invoke(
    name: str,
    path: str,
    method: str,
    body: str | None,
    header: list[str] | None,
    port: int,
) -> None:
    client = LwsClient(port=port)
    try:
        meta = await client.discover()
        services = meta.get("services", {})
        mock_info = services.get("mockserver", {})
        servers = mock_info.get("resources", [])
        server = next((s for s in servers if s.get("name") == name), None)
        if not server:
            exit_with_error(f"Mock server '{name}' not found in running instance")
        mock_port = server.get("port")
    except Exception as exc:
        exit_with_error(str(exc))

    headers: dict[str, str] = {}
    if header:
        for h in header:
            if ":" in h:
                key, val = h.split(":", 1)
                headers[key.strip()] = val.strip()

    import httpx  # pylint: disable=import-outside-toplevel

    try:
        async with httpx.AsyncClient() as http:
            resp = await http.request(
                method.upper(),
                f"http://localhost:{mock_port}{path}",
                content=body.encode() if body else None,
                headers=headers,
                timeout=30.0,
            )
            output_json(
                {
                    "status": resp.status_code,
                    "headers": dict(resp.headers),
                    "body": (
                        resp.json()
                        if resp.headers.get("content-type", "").startswith("application/json")
                        else resp.text
                    ),
                }
            )
    except Exception as exc:
        exit_with_error(str(exc))
