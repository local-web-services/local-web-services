"""``lws rds`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="RDS commands")

_SERVICE = "rds"
_TARGET_PREFIX = "AmazonRDSv19"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-db-instance")
def create_db_instance(
    db_instance_identifier: str = typer.Option(
        ..., "--db-instance-identifier", help="DB instance ID"
    ),
    db_instance_class: str = typer.Option(
        "db.t3.micro", "--db-instance-class", help="Instance class"
    ),
    engine: str = typer.Option("postgres", "--engine", help="Database engine (postgres or mysql)"),
    master_username: str = typer.Option("admin", "--master-username", help="Master username"),
    master_user_password: str = typer.Option(
        "password", "--master-user-password", help="Master user password"
    ),
    allocated_storage: int = typer.Option(20, "--allocated-storage", help="Storage in GB"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an RDS DB instance."""
    asyncio.run(
        _create_db_instance(
            db_instance_identifier,
            db_instance_class,
            engine,
            master_username,
            master_user_password,
            allocated_storage,
            port,
        )
    )


async def _create_db_instance(
    db_instance_identifier: str,
    db_instance_class: str,
    engine: str,
    master_username: str,
    master_user_password: str,
    allocated_storage: int,
    port: int,
) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateDBInstance",
            {
                "DBInstanceIdentifier": db_instance_identifier,
                "DBInstanceClass": db_instance_class,
                "Engine": engine,
                "MasterUsername": master_username,
                "MasterUserPassword": master_user_password,
                "AllocatedStorage": allocated_storage,
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-db-instances")
def describe_db_instances(
    db_instance_identifier: str = typer.Option(
        None, "--db-instance-identifier", help="Filter by instance ID"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe RDS DB instances."""
    asyncio.run(_describe_db_instances(db_instance_identifier, port))


async def _describe_db_instances(db_instance_identifier: str | None, port: int) -> None:
    client = _client(port)
    try:
        body: dict = {}
        if db_instance_identifier:
            body["DBInstanceIdentifier"] = db_instance_identifier
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeDBInstances",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-db-instance")
def delete_db_instance(
    db_instance_identifier: str = typer.Option(
        ..., "--db-instance-identifier", help="DB instance ID"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an RDS DB instance."""
    asyncio.run(_delete_db_instance(db_instance_identifier, port))


async def _delete_db_instance(db_instance_identifier: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteDBInstance",
            {"DBInstanceIdentifier": db_instance_identifier},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("create-db-cluster")
def create_db_cluster(
    db_cluster_identifier: str = typer.Option(..., "--db-cluster-identifier", help="Cluster ID"),
    engine: str = typer.Option("aurora-postgresql", "--engine", help="Cluster engine"),
    master_username: str = typer.Option("admin", "--master-username", help="Master username"),
    master_user_password: str = typer.Option(
        "password", "--master-user-password", help="Master user password"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an RDS DB cluster."""
    asyncio.run(
        _create_db_cluster(
            db_cluster_identifier, engine, master_username, master_user_password, port
        )
    )


async def _create_db_cluster(
    db_cluster_identifier: str,
    engine: str,
    master_username: str,
    master_user_password: str,
    port: int,
) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateDBCluster",
            {
                "DBClusterIdentifier": db_cluster_identifier,
                "Engine": engine,
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
    """Describe RDS DB clusters."""
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
