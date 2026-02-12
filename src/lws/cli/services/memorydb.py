"""``lws memorydb`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.experimental import warn_if_experimental
from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="MemoryDB commands")

_SERVICE = "memorydb"


@app.callback(invoke_without_command=True)
def _callback() -> None:
    warn_if_experimental(_SERVICE)


_TARGET_PREFIX = "AmazonMemoryDB"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-cluster")
def create_cluster(
    cluster_name: str = typer.Option(..., "--cluster-name", help="Cluster name"),
    node_type: str = typer.Option("db.t4g.small", "--node-type", help="Node type"),
    num_shards: int = typer.Option(1, "--num-shards", help="Number of shards"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a MemoryDB cluster."""
    asyncio.run(_create_cluster(cluster_name, node_type, num_shards, port))


async def _create_cluster(cluster_name: str, node_type: str, num_shards: int, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateCluster",
            {
                "ClusterName": cluster_name,
                "NodeType": node_type,
                "NumShards": num_shards,
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-clusters")
def describe_clusters(
    cluster_name: str = typer.Option(None, "--cluster-name", help="Filter by cluster name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe MemoryDB clusters."""
    asyncio.run(_describe_clusters(cluster_name, port))


async def _describe_clusters(cluster_name: str | None, port: int) -> None:
    client = _client(port)
    try:
        body: dict = {}
        if cluster_name:
            body["ClusterName"] = cluster_name
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeClusters",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-cluster")
def delete_cluster(
    cluster_name: str = typer.Option(..., "--cluster-name", help="Cluster name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a MemoryDB cluster."""
    asyncio.run(_delete_cluster(cluster_name, port))


async def _delete_cluster(cluster_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteCluster",
            {"ClusterName": cluster_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
