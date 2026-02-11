"""``lws neptune`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services._shared_commands import (
    create_db_cluster_cmd,
    delete_db_cluster_cmd,
    describe_db_clusters_cmd,
)

app = typer.Typer(help="Neptune commands")

_SERVICE = "neptune"
_TARGET_PREFIX = "AmazonNeptune"


@app.command("create-db-cluster")
def create_db_cluster(
    db_cluster_identifier: str = typer.Option(..., "--db-cluster-identifier", help="Cluster ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a Neptune cluster."""
    asyncio.run(
        create_db_cluster_cmd(
            _SERVICE,
            _TARGET_PREFIX,
            {
                "DBClusterIdentifier": db_cluster_identifier,
                "Engine": "neptune",
            },
            port,
        )
    )


@app.command("describe-db-clusters")
def describe_db_clusters(
    db_cluster_identifier: str = typer.Option(
        None, "--db-cluster-identifier", help="Filter by cluster ID"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe Neptune clusters."""
    asyncio.run(describe_db_clusters_cmd(_SERVICE, _TARGET_PREFIX, db_cluster_identifier, port))


@app.command("delete-db-cluster")
def delete_db_cluster(
    db_cluster_identifier: str = typer.Option(..., "--db-cluster-identifier", help="Cluster ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a Neptune cluster."""
    asyncio.run(delete_db_cluster_cmd(_SERVICE, _TARGET_PREFIX, db_cluster_identifier, port))
