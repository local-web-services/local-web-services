"""Shared async CLI helpers for describe/delete commands.

Several services (docdb, neptune, rds, es, opensearch) have identical
describe/delete/list command implementations that differ only in the
service name and target prefix.  This module extracts those patterns.
"""

from __future__ import annotations

from lws.cli.services.client import LwsClient, exit_with_error, output_json

# ------------------------------------------------------------------
# Cluster-DB helpers (DocDB, Neptune, RDS)
# ------------------------------------------------------------------


async def create_db_cluster_cmd(
    service: str,
    target_prefix: str,
    body: dict,
    port: int,
) -> None:
    """Shared implementation for create-db-cluster commands."""
    client = LwsClient(port=port)
    try:
        result = await client.json_target_request(
            service,
            f"{target_prefix}.CreateDBCluster",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


async def describe_db_clusters_cmd(
    service: str,
    target_prefix: str,
    db_cluster_identifier: str | None,
    port: int,
) -> None:
    """Shared implementation for describe-db-clusters commands."""
    client = LwsClient(port=port)
    try:
        body: dict = {}
        if db_cluster_identifier:
            body["DBClusterIdentifier"] = db_cluster_identifier
        result = await client.json_target_request(
            service,
            f"{target_prefix}.DescribeDBClusters",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


async def delete_db_cluster_cmd(
    service: str,
    target_prefix: str,
    db_cluster_identifier: str,
    port: int,
) -> None:
    """Shared implementation for delete-db-cluster commands."""
    client = LwsClient(port=port)
    try:
        result = await client.json_target_request(
            service,
            f"{target_prefix}.DeleteDBCluster",
            {"DBClusterIdentifier": db_cluster_identifier},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


# ------------------------------------------------------------------
# Search-service helpers (Elasticsearch, OpenSearch)
# ------------------------------------------------------------------


async def describe_domain_cmd(
    service: str,
    target_prefix: str,
    action: str,
    domain_name: str,
    port: int,
) -> None:
    """Shared implementation for describe-domain commands."""
    client = LwsClient(port=port)
    try:
        result = await client.json_target_request(
            service,
            f"{target_prefix}.{action}",
            {"DomainName": domain_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


async def delete_domain_cmd(
    service: str,
    target_prefix: str,
    action: str,
    domain_name: str,
    port: int,
) -> None:
    """Shared implementation for delete-domain commands."""
    client = LwsClient(port=port)
    try:
        result = await client.json_target_request(
            service,
            f"{target_prefix}.{action}",
            {"DomainName": domain_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


async def list_domain_names_cmd(
    service: str,
    target_prefix: str,
    port: int,
) -> None:
    """Shared implementation for list-domain-names commands."""
    client = LwsClient(port=port)
    try:
        result = await client.json_target_request(
            service,
            f"{target_prefix}.ListDomainNames",
            {},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
