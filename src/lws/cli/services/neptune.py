"""``lws neptune`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="Neptune commands")

_SERVICE = "neptune"
_TARGET_PREFIX = "AmazonNeptune"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-db-cluster")
def create_db_cluster(
    db_cluster_identifier: str = typer.Option(..., "--db-cluster-identifier", help="Cluster ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a Neptune cluster."""
    asyncio.run(_create_db_cluster(db_cluster_identifier, port))


async def _create_db_cluster(db_cluster_identifier: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateDBCluster",
            {
                "DBClusterIdentifier": db_cluster_identifier,
                "Engine": "neptune",
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-db-clusters")
def describe_db_clusters(
    db_cluster_identifier: str = typer.Option(
        None, "--db-cluster-identifier", help="Filter by cluster ID"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe Neptune clusters."""
    asyncio.run(_describe_db_clusters(db_cluster_identifier, port))


async def _describe_db_clusters(db_cluster_identifier: str | None, port: int) -> None:
    client = _client(port)
    try:
        body: dict = {}
        if db_cluster_identifier:
            body["DBClusterIdentifier"] = db_cluster_identifier
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeDBClusters",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-db-cluster")
def delete_db_cluster(
    db_cluster_identifier: str = typer.Option(..., "--db-cluster-identifier", help="Cluster ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a Neptune cluster."""
    asyncio.run(_delete_db_cluster(db_cluster_identifier, port))


async def _delete_db_cluster(db_cluster_identifier: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteDBCluster",
            {"DBClusterIdentifier": db_cluster_identifier},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
