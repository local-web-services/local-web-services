"""CLI commands for AWS service chaos engineering.

Provides ``lws chaos`` sub-commands to enable, disable, query, and
configure chaos injection on running AWS service providers.
"""

from __future__ import annotations

import asyncio
from typing import Any

import typer

from lws.cli.services.client import build_chaos_body, exit_with_error, ldk_get, ldk_post

app = typer.Typer(help="Chaos engineering for AWS service providers.")


@app.command("enable")
def enable(
    service: str = typer.Argument(..., help="Service name (e.g. dynamodb, s3, sqs)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Enable chaos for a service."""
    asyncio.run(ldk_post(port, "/_ldk/chaos", {service: {"enabled": True}}))


@app.command("disable")
def disable(
    service: str = typer.Argument(..., help="Service name (e.g. dynamodb, s3, sqs)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Disable chaos for a service."""
    asyncio.run(ldk_post(port, "/_ldk/chaos", {service: {"enabled": False}}))


@app.command("status")
def status(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Show chaos configuration for all services."""
    asyncio.run(ldk_get(port, "/_ldk/chaos"))


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
    asyncio.run(ldk_post(port, "/_ldk/chaos", {service: body}))


def _build_chaos_update(service: str, overrides: dict[str, Any]) -> dict[str, Any]:
    """Wrap overrides in a service-keyed dict for the chaos API."""
    return {service: overrides}
