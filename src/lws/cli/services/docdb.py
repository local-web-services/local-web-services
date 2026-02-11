"""``lws docdb`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="DocumentDB commands")

_SERVICE = "docdb"
_TARGET_PREFIX = "AmazonRDSv19"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-db-cluster")
def create_db_cluster(
    db_cluster_identifier: str = typer.Option(..., "--db-cluster-identifier", help="Cluster ID"),
    master_username: str = typer.Option("admin", "--master-username", help="Master username"),
    master_user_password: str = typer.Option(
        "password", "--master-user-password", help="Master user password"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a DocumentDB cluster."""
    asyncio.run(
        _create_db_cluster(db_cluster_identifier, master_username, master_user_password, port)
    )


async def _create_db_cluster(
    db_cluster_identifier: str, master_username: str, master_user_password: str, port: int
) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateDBCluster",
            {
                "DBClusterIdentifier": db_cluster_identifier,
                "Engine": "docdb",
                "MasterUsername": master_username,
                "MasterUserPassword": master_user_password,
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
    """Describe DocumentDB clusters."""
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
    """Delete a DocumentDB cluster."""
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
