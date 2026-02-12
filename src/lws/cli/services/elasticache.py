"""``lws elasticache`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.experimental import warn_if_experimental
from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="ElastiCache commands")

_SERVICE = "elasticache"


@app.callback(invoke_without_command=True)
def _callback() -> None:
    warn_if_experimental(_SERVICE)


_TARGET_PREFIX = "AmazonElastiCache"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-cache-cluster")
def create_cache_cluster(
    cache_cluster_id: str = typer.Option(..., "--cache-cluster-id", help="Cache cluster ID"),
    engine: str = typer.Option("redis", "--engine", help="Engine (redis or memcached)"),
    num_cache_nodes: int = typer.Option(1, "--num-cache-nodes", help="Number of cache nodes"),
    cache_node_type: str = typer.Option(
        "cache.t3.micro", "--cache-node-type", help="Cache node type"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a cache cluster."""
    asyncio.run(
        _create_cache_cluster(cache_cluster_id, engine, num_cache_nodes, cache_node_type, port)
    )


async def _create_cache_cluster(
    cache_cluster_id: str,
    engine: str,
    num_cache_nodes: int,
    cache_node_type: str,
    port: int,
) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateCacheCluster",
            {
                "CacheClusterId": cache_cluster_id,
                "Engine": engine,
                "NumCacheNodes": num_cache_nodes,
                "CacheNodeType": cache_node_type,
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-cache-clusters")
def describe_cache_clusters(
    cache_cluster_id: str = typer.Option(None, "--cache-cluster-id", help="Filter by cluster ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe cache clusters."""
    asyncio.run(_describe_cache_clusters(cache_cluster_id, port))


async def _describe_cache_clusters(cache_cluster_id: str | None, port: int) -> None:
    client = _client(port)
    try:
        body: dict = {}
        if cache_cluster_id:
            body["CacheClusterId"] = cache_cluster_id
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeCacheClusters",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-cache-cluster")
def delete_cache_cluster(
    cache_cluster_id: str = typer.Option(..., "--cache-cluster-id", help="Cache cluster ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a cache cluster."""
    asyncio.run(_delete_cache_cluster(cache_cluster_id, port))


async def _delete_cache_cluster(cache_cluster_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteCacheCluster",
            {"CacheClusterId": cache_cluster_id},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
