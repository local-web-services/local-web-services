"""LWS CLI entry point.

Provides AWS CLI-style commands for interacting with local LDK resources.
Requires a running ``ldk dev`` instance.
"""

from __future__ import annotations

import asyncio

import httpx
import typer

from lws.cli.services.apigateway import app as apigateway_app
from lws.cli.services.client import exit_with_error, output_json
from lws.cli.services.cognito import app as cognito_app
from lws.cli.services.dynamodb import app as dynamodb_app
from lws.cli.services.events import app as events_app
from lws.cli.services.s3 import app as s3_app
from lws.cli.services.sns import app as sns_app
from lws.cli.services.sqs import app as sqs_app
from lws.cli.services.stepfunctions import app as stepfunctions_app

app = typer.Typer(
    name="lws",
    help="AWS CLI-style commands for local LDK resources. Requires a running 'ldk dev' instance.",
)

app.add_typer(apigateway_app, name="apigateway")
app.add_typer(stepfunctions_app, name="stepfunctions")
app.add_typer(sqs_app, name="sqs")
app.add_typer(sns_app, name="sns")
app.add_typer(s3_app, name="s3api")
app.add_typer(dynamodb_app, name="dynamodb")
app.add_typer(events_app, name="events")
app.add_typer(cognito_app, name="cognito-idp")


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

    from rich.console import Console
    from rich.table import Table

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
