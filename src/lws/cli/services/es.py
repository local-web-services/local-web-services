"""``lws es`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="Elasticsearch Service commands")

_SERVICE = "es"
_TARGET_PREFIX = "ElasticsearchService_20150101"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-elasticsearch-domain")
def create_elasticsearch_domain(
    domain_name: str = typer.Option(..., "--domain-name", help="Domain name"),
    elasticsearch_version: str = typer.Option(
        "7.10", "--elasticsearch-version", help="Elasticsearch version"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an Elasticsearch domain."""
    asyncio.run(_create_domain(domain_name, elasticsearch_version, port))


async def _create_domain(domain_name: str, elasticsearch_version: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateElasticsearchDomain",
            {
                "DomainName": domain_name,
                "ElasticsearchVersion": elasticsearch_version,
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-elasticsearch-domain")
def describe_elasticsearch_domain(
    domain_name: str = typer.Option(..., "--domain-name", help="Domain name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe an Elasticsearch domain."""
    asyncio.run(_describe_domain(domain_name, port))


async def _describe_domain(domain_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeElasticsearchDomain",
            {"DomainName": domain_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-elasticsearch-domain")
def delete_elasticsearch_domain(
    domain_name: str = typer.Option(..., "--domain-name", help="Domain name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an Elasticsearch domain."""
    asyncio.run(_delete_domain(domain_name, port))


async def _delete_domain(domain_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteElasticsearchDomain",
            {"DomainName": domain_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-domain-names")
def list_domain_names(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all Elasticsearch domain names."""
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
