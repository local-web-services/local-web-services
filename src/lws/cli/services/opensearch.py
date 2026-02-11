"""``lws opensearch`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="OpenSearch Service commands")

_SERVICE = "opensearch"
_TARGET_PREFIX = "OpenSearchService_20210101"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


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
    client = _client(port)
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
    asyncio.run(_describe_domain(domain_name, port))


async def _describe_domain(domain_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeDomain",
            {"DomainName": domain_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-domain")
def delete_domain(
    domain_name: str = typer.Option(..., "--domain-name", help="Domain name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an OpenSearch domain."""
    asyncio.run(_delete_domain(domain_name, port))


async def _delete_domain(domain_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteDomain",
            {"DomainName": domain_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-domain-names")
def list_domain_names(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all OpenSearch domain names."""
    asyncio.run(_list_domain_names(port))


async def _list_domain_names(port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListDomainNames",
            {},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
