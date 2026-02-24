"""CLI commands for IAM authentication management.

Provides ``lws iam-auth`` sub-commands to query and configure IAM auth
on running AWS service providers.
"""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import ldk_get, ldk_post

app = typer.Typer(help="IAM authentication management for AWS service providers.")


@app.command("status")
def status(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Show IAM auth configuration."""
    asyncio.run(ldk_get(port, "/_ldk/iam-auth"))


@app.command("enable")
def enable(
    service: str = typer.Argument(..., help="Service name (e.g. dynamodb, s3, sqs)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Enable IAM auth for a service in enforce mode."""
    asyncio.run(ldk_post(port, "/_ldk/iam-auth", {"services": {service: {"mode": "enforce"}}}))


@app.command("disable")
def disable(
    service: str = typer.Argument(..., help="Service name (e.g. dynamodb, s3, sqs)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Disable IAM auth for a service."""
    asyncio.run(ldk_post(port, "/_ldk/iam-auth", {"services": {service: {"mode": "disabled"}}}))


@app.command("set")
def set_config(
    service: str = typer.Argument(..., help="Service name (e.g. dynamodb, s3, sqs)"),
    mode: str = typer.Option(..., "--mode", help="IAM auth mode (enforce, audit, disabled)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set IAM auth mode for a service."""
    asyncio.run(ldk_post(port, "/_ldk/iam-auth", {"services": {service: {"mode": mode}}}))


@app.command("set-identity")
def set_identity(
    identity: str = typer.Argument(..., help="Identity name to use as default"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set the default identity for IAM auth checks."""
    asyncio.run(ldk_post(port, "/_ldk/iam-auth", {"default_identity": identity}))
