"""``lws docdb`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.experimental import warn_if_experimental
from lws.cli.services._shared_commands import (
    create_db_cluster_cmd,
    delete_db_cluster_cmd,
    describe_db_clusters_cmd,
)

app = typer.Typer(help="DocumentDB commands")

_SERVICE = "docdb"


@app.callback(invoke_without_command=True)
def _callback() -> None:
    warn_if_experimental(_SERVICE)


_TARGET_PREFIX = "AmazonRDSv19"


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
        create_db_cluster_cmd(
            _SERVICE,
            _TARGET_PREFIX,
            {
                "DBClusterIdentifier": db_cluster_identifier,
                "Engine": "docdb",
                "MasterUsername": master_username,
                "MasterUserPassword": master_user_password,
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
    """Describe DocumentDB clusters."""
    asyncio.run(describe_db_clusters_cmd(_SERVICE, _TARGET_PREFIX, db_cluster_identifier, port))


@app.command("delete-db-cluster")
def delete_db_cluster(
    db_cluster_identifier: str = typer.Option(..., "--db-cluster-identifier", help="Cluster ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a DocumentDB cluster."""
    asyncio.run(delete_db_cluster_cmd(_SERVICE, _TARGET_PREFIX, db_cluster_identifier, port))
