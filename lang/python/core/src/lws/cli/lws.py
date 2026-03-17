"""LWS CLI entry point.

Provides management commands for interacting with a running ``ldk dev`` instance.
For AWS service operations, use the standard AWS CLI with ``--endpoint-url``
pointing at the local service port shown by ``lws status``.
"""

from __future__ import annotations

import asyncio

import httpx
import typer

from lws.cli.experimental import EXPERIMENTAL_SERVICES
from lws.cli.init import init_command
from lws.cli.services.aws_fake import app as aws_fake_app
from lws.cli.services.chaos import app as chaos_app
from lws.cli.services.client import exit_with_error, output_json
from lws.cli.services.fake import app as fake_app
from lws.cli.services.iam_auth import app as iam_auth_app

app = typer.Typer(
    name="lws",
    help="Management commands for a running 'ldk dev' instance. Use the AWS CLI with --endpoint-url for service operations.",
)


def _add_service(typer_app: typer.Typer, name: str) -> None:
    """Register a service typer, appending [experimental] to help when appropriate."""
    if name in EXPERIMENTAL_SERVICES:
        original_help = typer_app.info.help or ""
        app.add_typer(typer_app, name=name, help=f"{original_help} [experimental]")
    else:
        app.add_typer(typer_app, name=name)


_add_service(fake_app, "fake")
_add_service(aws_fake_app, "aws-fake")
_add_service(chaos_app, "chaos")
_add_service(iam_auth_app, "iam-auth")

app.command("init")(init_command)


@app.command("status")
def status(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
    json_output: bool = typer.Option(False, "--json", help="Output as JSON"),
) -> None:
    """Show the status of the running ldk dev instance and all providers."""
    asyncio.run(_run_status(port, json_output=json_output))


async def _run_status(port: int, *, json_output: bool = False) -> None:
    base = f"http://localhost:{port}"
    try:
        async with httpx.AsyncClient() as client:
            status_resp = await client.get(f"{base}/_ldk/status", timeout=5.0)
            status_resp.raise_for_status()
            status_data = status_resp.json()

            resources_resp = await client.get(f"{base}/_ldk/resources", timeout=5.0)
            resources_resp.raise_for_status()
            resources_data = resources_resp.json()
    except (httpx.ConnectError, httpx.ConnectTimeout):
        exit_with_error(f"Cannot reach ldk dev on port {port}. Is it running?")

    providers = status_data.get("providers", [])
    services = resources_data.get("services", {})
    service_list = [
        {"name": name, "port": svc.get("port"), "resources": len(svc.get("resources", []))}
        for name, svc in services.items()
    ]

    if json_output:
        output_json(
            {
                "running": status_data.get("running", False),
                "providers": providers,
                "services": service_list,
            }
        )
        return

    from rich.console import Console  # pylint: disable=import-outside-toplevel
    from rich.table import Table  # pylint: disable=import-outside-toplevel

    console = Console()

    running = status_data.get("running", False)
    if running:
        console.print("[bold green]LDK is running[/bold green]")
    else:
        console.print("[bold yellow]LDK is not fully started[/bold yellow]")

    console.print()
    table = Table(title="Providers")
    table.add_column("Provider", style="cyan")
    table.add_column("Status")

    for p in providers:
        healthy = p.get("healthy", False)
        icon = "[green]healthy[/green]" if healthy else "[red]unhealthy[/red]"
        table.add_row(p.get("name", "unknown"), icon)

    console.print(table)

    if service_list:
        console.print()
        svc_table = Table(title="Services")
        svc_table.add_column("Service", style="cyan")
        svc_table.add_column("Port", style="magenta")
        svc_table.add_column("Resources", justify="right")

        for svc in service_list:
            svc_table.add_row(svc["name"], str(svc["port"]), str(svc["resources"]))

        console.print(svc_table)
