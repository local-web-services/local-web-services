"""LWS CLI entry point.

Provides AWS CLI-style commands for interacting with local LDK resources.
Requires a running ``ldk dev`` instance.
"""

from __future__ import annotations

import asyncio

import httpx
import typer

from lws.cli.experimental import EXPERIMENTAL_SERVICES
from lws.cli.services.apigateway import app as apigateway_app
from lws.cli.services.aws_mock import app as aws_mock_app
from lws.cli.services.chaos import app as chaos_app
from lws.cli.services.client import exit_with_error, output_json
from lws.cli.services.cognito import app as cognito_app
from lws.cli.services.docdb import app as docdb_app
from lws.cli.services.dynamodb import app as dynamodb_app
from lws.cli.services.elasticache import app as elasticache_app
from lws.cli.services.es import app as es_app
from lws.cli.services.events import app as events_app
from lws.cli.services.glacier import app as glacier_app
from lws.cli.services.lambda_service import app as lambda_app
from lws.cli.services.memorydb import app as memorydb_app
from lws.cli.services.mock import app as mock_app
from lws.cli.services.neptune import app as neptune_app
from lws.cli.services.opensearch import app as opensearch_app
from lws.cli.services.rds import app as rds_app
from lws.cli.services.s3 import app as s3_app
from lws.cli.services.s3tables import app as s3tables_app
from lws.cli.services.secretsmanager import app as secretsmanager_app
from lws.cli.services.sns import app as sns_app
from lws.cli.services.sqs import app as sqs_app
from lws.cli.services.ssm import app as ssm_app
from lws.cli.services.stepfunctions import app as stepfunctions_app

app = typer.Typer(
    name="lws",
    help="AWS CLI-style commands for local LDK resources. Requires a running 'ldk dev' instance.",
)


def _add_service(typer_app: typer.Typer, name: str) -> None:
    """Register a service typer, appending [experimental] to help when appropriate."""
    if name in EXPERIMENTAL_SERVICES:
        original_help = typer_app.info.help or ""
        app.add_typer(typer_app, name=name, help=f"{original_help} [experimental]")
    else:
        app.add_typer(typer_app, name=name)


_add_service(apigateway_app, "apigateway")
_add_service(stepfunctions_app, "stepfunctions")
_add_service(sqs_app, "sqs")
_add_service(sns_app, "sns")
_add_service(s3_app, "s3api")
_add_service(dynamodb_app, "dynamodb")
_add_service(events_app, "events")
_add_service(lambda_app, "lambda")
_add_service(cognito_app, "cognito-idp")
_add_service(ssm_app, "ssm")
_add_service(secretsmanager_app, "secretsmanager")
_add_service(elasticache_app, "elasticache")
_add_service(memorydb_app, "memorydb")
_add_service(docdb_app, "docdb")
_add_service(neptune_app, "neptune")
_add_service(es_app, "es")
_add_service(opensearch_app, "opensearch")
_add_service(rds_app, "rds")
_add_service(glacier_app, "glacier")
_add_service(s3tables_app, "s3tables")
_add_service(mock_app, "mock")
_add_service(aws_mock_app, "aws-mock")
_add_service(chaos_app, "chaos")


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
