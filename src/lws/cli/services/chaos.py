"""CLI commands for AWS service chaos engineering.

Provides ``lws chaos`` sub-commands to enable, disable, query, and
configure chaos injection on running AWS service providers.
"""

from __future__ import annotations

import asyncio
from typing import Any

import httpx
import typer

from lws.cli.services.client import build_chaos_body, exit_with_error, output_json

app = typer.Typer(help="Chaos engineering for AWS service providers.")


@app.command("enable")
def enable(
    service: str = typer.Argument(..., help="Service name (e.g. dynamodb, s3, sqs)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Enable chaos for a service."""
    asyncio.run(_update_chaos(port, service, {"enabled": True}))


@app.command("disable")
def disable(
    service: str = typer.Argument(..., help="Service name (e.g. dynamodb, s3, sqs)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Disable chaos for a service."""
    asyncio.run(_update_chaos(port, service, {"enabled": False}))


@app.command("status")
def status(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Show chaos configuration for all services."""
    asyncio.run(_get_chaos_status(port))


@app.command("set")
def set_config(
    service: str = typer.Argument(..., help="Service name (e.g. dynamodb, s3, sqs)"),
    error_rate: float = typer.Option(None, "--error-rate", help="Error injection probability"),
    latency_min: int = typer.Option(None, "--latency-min", help="Min latency ms"),
    latency_max: int = typer.Option(None, "--latency-max", help="Max latency ms"),
    timeout_rate: float = typer.Option(None, "--timeout-rate", help="Timeout probability"),
    connection_reset_rate: float = typer.Option(
        None, "--connection-reset-rate", help="Connection reset probability"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update chaos parameters for a service."""
    body = build_chaos_body(
        error_rate=error_rate,
        latency_min=latency_min,
        latency_max=latency_max,
        timeout_rate=timeout_rate,
        connection_reset_rate=connection_reset_rate,
    )
    if not body:
        exit_with_error("No chaos parameters specified. Use --error-rate, --latency-min, etc.")
    asyncio.run(_update_chaos(port, service, body))


async def _get_chaos_status(port: int) -> None:
    """Fetch and display chaos status for all services."""
    base = f"http://localhost:{port}"
    try:
        async with httpx.AsyncClient() as client:
            resp = await client.get(f"{base}/_ldk/chaos", timeout=5.0)
            resp.raise_for_status()
            output_json(resp.json())
    except (httpx.ConnectError, httpx.ConnectTimeout):
        exit_with_error(f"Cannot reach ldk dev on port {port}. Is it running?")


async def _update_chaos(port: int, service: str, overrides: dict[str, Any]) -> None:
    """Send chaos config update to the management API."""
    base = f"http://localhost:{port}"
    try:
        async with httpx.AsyncClient() as client:
            resp = await client.post(
                f"{base}/_ldk/chaos",
                json={service: overrides},
                timeout=5.0,
            )
            resp.raise_for_status()
            output_json(resp.json())
    except (httpx.ConnectError, httpx.ConnectTimeout):
        exit_with_error(f"Cannot reach ldk dev on port {port}. Is it running?")
