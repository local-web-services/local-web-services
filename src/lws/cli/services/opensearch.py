"""``lws opensearch`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.experimental import warn_if_experimental
from lws.cli.services._shared_commands import (
    delete_domain_cmd,
    describe_domain_cmd,
    list_domain_names_cmd,
)
from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="OpenSearch Service commands")

_SERVICE = "opensearch"


@app.callback(invoke_without_command=True)
def _callback() -> None:
    warn_if_experimental(_SERVICE)


_TARGET_PREFIX = "OpenSearchService_20210101"


@app.command("create-domain")
def create_domain(
    domain_name: str = typer.Option(..., "--domain-name", help="Domain name"),
    engine_version: str = typer.Option(
        "OpenSearch_2.11", "--engine-version", help="Engine version"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an OpenSearch domain."""
    asyncio.run(_create_domain(domain_name, engine_version, port))


async def _create_domain(domain_name: str, engine_version: str, port: int) -> None:
    client = LwsClient(port=port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateDomain",
            {
                "DomainName": domain_name,
                "EngineVersion": engine_version,
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-domain")
def describe_domain(
    domain_name: str = typer.Option(..., "--domain-name", help="Domain name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe an OpenSearch domain."""
    asyncio.run(describe_domain_cmd(_SERVICE, _TARGET_PREFIX, "DescribeDomain", domain_name, port))


@app.command("delete-domain")
def delete_domain(
    domain_name: str = typer.Option(..., "--domain-name", help="Domain name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an OpenSearch domain."""
    asyncio.run(delete_domain_cmd(_SERVICE, _TARGET_PREFIX, "DeleteDomain", domain_name, port))


@app.command("list-domain-names")
def list_domain_names(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all OpenSearch domain names."""
    asyncio.run(list_domain_names_cmd(_SERVICE, _TARGET_PREFIX, port))
