"""RDS HTTP routes.

Implements the RDS control-plane wire protocol that AWS SDKs and Terraform use,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers._shared.resource_container import ResourceContainerManager
from lws.providers._shared.response_helpers import (
    error_response as _error_response,
)
from lws.providers._shared.response_helpers import (
    iso_now as _iso_now,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)
from lws.providers._shared.response_helpers import (
    parse_endpoint as _parse_endpoint,
)

_logger = get_logger("ldk.rds")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _DBInstance:
    """Represents an RDS DB instance."""

    def __init__(
        self,
        db_instance_identifier: str,
        db_instance_class: str,
        engine: str,
        master_username: str,
        allocated_storage: int,
        db_cluster_identifier: str | None = None,
        data_plane_endpoint: str | None = None,
    ) -> None:
        self.db_instance_identifier = db_instance_identifier
        self.db_instance_class = db_instance_class
        self.engine = engine
        self.master_username = master_username
        self.allocated_storage = allocated_storage
        self.status = "available"
        self.arn = f"arn:aws:rds:{_REGION}:{_ACCOUNT_ID}:db:{db_instance_identifier}"
        if data_plane_endpoint:
            addr, pt = _parse_endpoint(data_plane_endpoint)
            self.endpoint = {"Address": addr, "Port": pt}
        else:
            self.endpoint = {
                "Address": f"{db_instance_identifier}.local.{_REGION}.rds.amazonaws.com",
                "Port": 5432 if engine == "postgres" else 3306,
            }
        self.db_cluster_identifier = db_cluster_identifier
        self.tags: dict[str, str] = {}
        self.created_date = _iso_now()


class _DBCluster:
    """Represents an RDS DB cluster."""

    def __init__(
        self,
        db_cluster_identifier: str,
        engine: str,
        master_username: str,
        data_plane_endpoint: str | None = None,
    ) -> None:
        self.db_cluster_identifier = db_cluster_identifier
        self.engine = engine
        self.master_username = master_username
        self.status = "available"
        self.arn = f"arn:aws:rds:{_REGION}:{_ACCOUNT_ID}:cluster:{db_cluster_identifier}"
        if data_plane_endpoint:
            self.endpoint, self.port = _parse_endpoint(data_plane_endpoint)
        else:
            self.endpoint = f"{db_cluster_identifier}.cluster-local.{_REGION}.rds.amazonaws.com"
            self.port = 5432 if engine == "postgres" else 3306
        self.tags: dict[str, str] = {}
        self.created_date = _iso_now()


class _RdsState:
    """In-memory store for RDS instances and clusters."""

    def __init__(
        self,
        *,
        postgres_container_manager: ResourceContainerManager | None = None,
        mysql_container_manager: ResourceContainerManager | None = None,
    ) -> None:
        self._instances: dict[str, _DBInstance] = {}
        self._clusters: dict[str, _DBCluster] = {}
        self.postgres_container_manager = postgres_container_manager
        self.mysql_container_manager = mysql_container_manager

    @property
    def instances(self) -> dict[str, _DBInstance]:
        """Return the instances store."""
        return self._instances

    @property
    def clusters(self) -> dict[str, _DBCluster]:
        """Return the clusters store."""
        return self._clusters


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _format_db_instance(instance: _DBInstance) -> dict[str, Any]:
    """Format a DB instance for API response."""
    result: dict[str, Any] = {
        "DBInstanceIdentifier": instance.db_instance_identifier,
        "DBInstanceClass": instance.db_instance_class,
        "Engine": instance.engine,
        "DBInstanceStatus": instance.status,
        "MasterUsername": instance.master_username,
        "AllocatedStorage": instance.allocated_storage,
        "Endpoint": instance.endpoint,
        "DBInstanceArn": instance.arn,
        "InstanceCreateTime": instance.created_date,
        "TagList": [{"Key": k, "Value": v} for k, v in instance.tags.items()],
    }
    if instance.db_cluster_identifier is not None:
        result["DBClusterIdentifier"] = instance.db_cluster_identifier
    return result


def _format_db_cluster(cluster: _DBCluster) -> dict[str, Any]:
    """Format a DB cluster for API response."""
    return {
        "DBClusterIdentifier": cluster.db_cluster_identifier,
        "Engine": cluster.engine,
        "Status": cluster.status,
        "MasterUsername": cluster.master_username,
        "Endpoint": cluster.endpoint,
        "Port": cluster.port,
        "DBClusterArn": cluster.arn,
        "ClusterCreateTime": cluster.created_date,
        "TagList": [{"Key": k, "Value": v} for k, v in cluster.tags.items()],
    }


def _find_resource_tags(state: _RdsState, resource_arn: str) -> dict[str, str] | None:
    """Find the tags dict for a resource by its ARN. Returns None if not found."""
    for instance in state.instances.values():
        if instance.arn == resource_arn:
            return instance.tags
    for cluster in state.clusters.values():
        if cluster.arn == resource_arn:
            return cluster.tags
    return None


# ------------------------------------------------------------------
# Static engine version data
# ------------------------------------------------------------------


_ENGINE_VERSIONS: dict[str, list[dict[str, Any]]] = {
    "postgres": [
        {
            "Engine": "postgres",
            "EngineVersion": "14.17",
            "DBParameterGroupFamily": "postgres14",
            "DBEngineDescription": "PostgreSQL",
            "DBEngineVersionDescription": "PostgreSQL 14.17",
        },
        {
            "Engine": "postgres",
            "EngineVersion": "15.12",
            "DBParameterGroupFamily": "postgres15",
            "DBEngineDescription": "PostgreSQL",
            "DBEngineVersionDescription": "PostgreSQL 15.12",
        },
        {
            "Engine": "postgres",
            "EngineVersion": "16.8",
            "DBParameterGroupFamily": "postgres16",
            "DBEngineDescription": "PostgreSQL",
            "DBEngineVersionDescription": "PostgreSQL 16.8",
        },
    ],
    "mysql": [
        {
            "Engine": "mysql",
            "EngineVersion": "8.0.36",
            "DBParameterGroupFamily": "mysql8.0",
            "DBEngineDescription": "MySQL Community Edition",
            "DBEngineVersionDescription": "MySQL 8.0.36",
        },
        {
            "Engine": "mysql",
            "EngineVersion": "8.0.37",
            "DBParameterGroupFamily": "mysql8.0",
            "DBEngineDescription": "MySQL Community Edition",
            "DBEngineVersionDescription": "MySQL 8.0.37",
        },
        {
            "Engine": "mysql",
            "EngineVersion": "8.0.39",
            "DBParameterGroupFamily": "mysql8.0",
            "DBEngineDescription": "MySQL Community Edition",
            "DBEngineVersionDescription": "MySQL 8.0.39",
        },
    ],
}


# ------------------------------------------------------------------
# Action handlers
# ------------------------------------------------------------------


async def _handle_create_db_instance(state: _RdsState, body: dict) -> Response:
    """Handle CreateDBInstance."""
    db_instance_id = body.get("DBInstanceIdentifier", "")
    if not db_instance_id:
        return _error_response(
            "InvalidParameterValue",
            "DBInstanceIdentifier is required.",
        )

    if db_instance_id in state.instances:
        return _error_response(
            "DBInstanceAlreadyExistsFault",
            f"DB instance already exists: {db_instance_id}",
        )

    engine = body.get("Engine", "postgres")
    cluster_id = body.get("DBClusterIdentifier")
    endpoint = None
    if cluster_id and cluster_id in state.clusters:
        cluster = state.clusters[cluster_id]
        endpoint = f"{cluster.endpoint}:{cluster.port}"
    else:
        if engine == "postgres":
            cm = state.postgres_container_manager
        else:
            cm = state.mysql_container_manager
        if cm:
            endpoint = await cm.start_container(db_instance_id)
    instance = _DBInstance(
        db_instance_identifier=db_instance_id,
        db_instance_class=body.get("DBInstanceClass", "db.t3.micro"),
        engine=engine,
        master_username=body.get("MasterUsername", "admin"),
        allocated_storage=body.get("AllocatedStorage", 20),
        db_cluster_identifier=cluster_id,
        data_plane_endpoint=endpoint,
    )
    state.instances[db_instance_id] = instance

    return _json_response({"DBInstance": _format_db_instance(instance)})


async def _handle_describe_db_instances(state: _RdsState, body: dict) -> Response:
    """Handle DescribeDBInstances."""
    db_instance_id = body.get("DBInstanceIdentifier")

    if db_instance_id:
        instance = state.instances.get(db_instance_id)
        if instance is None:
            return _error_response(
                "DBInstanceNotFoundFault",
                f"DB instance not found: {db_instance_id}",
                status_code=404,
            )
        return _json_response({"DBInstances": [_format_db_instance(instance)]})

    instances = [_format_db_instance(i) for i in state.instances.values()]
    return _json_response({"DBInstances": instances})


async def _handle_delete_db_instance(state: _RdsState, body: dict) -> Response:
    """Handle DeleteDBInstance."""
    db_instance_id = body.get("DBInstanceIdentifier", "")

    instance = state.instances.get(db_instance_id)
    if instance is None:
        return _error_response(
            "DBInstanceNotFoundFault",
            f"DB instance not found: {db_instance_id}",
            status_code=404,
        )

    del state.instances[db_instance_id]
    if not instance.db_cluster_identifier:
        if instance.engine == "postgres":
            cm = state.postgres_container_manager
        else:
            cm = state.mysql_container_manager
        if cm:
            await cm.stop_container(db_instance_id)
    instance.status = "deleting"
    return _json_response({"DBInstance": _format_db_instance(instance)})


async def _handle_modify_db_instance(state: _RdsState, body: dict) -> Response:
    """Handle ModifyDBInstance."""
    db_instance_id = body.get("DBInstanceIdentifier", "")

    instance = state.instances.get(db_instance_id)
    if instance is None:
        return _error_response(
            "DBInstanceNotFoundFault",
            f"DB instance not found: {db_instance_id}",
            status_code=404,
        )

    if "DBInstanceClass" in body:
        instance.db_instance_class = body["DBInstanceClass"]
    if "AllocatedStorage" in body:
        instance.allocated_storage = body["AllocatedStorage"]
    if "MasterUserPassword" in body:
        pass  # Password change acknowledged but not stored in plain text
    if "Engine" in body:
        instance.engine = body["Engine"]
        instance.endpoint["Port"] = 5432 if body["Engine"] == "postgres" else 3306

    return _json_response({"DBInstance": _format_db_instance(instance)})


async def _handle_create_db_cluster(state: _RdsState, body: dict) -> Response:
    """Handle CreateDBCluster."""
    db_cluster_id = body.get("DBClusterIdentifier", "")
    if not db_cluster_id:
        return _error_response(
            "InvalidParameterValue",
            "DBClusterIdentifier is required.",
        )

    if db_cluster_id in state.clusters:
        return _error_response(
            "DBClusterAlreadyExistsFault",
            f"DB cluster already exists: {db_cluster_id}",
        )

    engine = body.get("Engine", "postgres")
    cm = state.postgres_container_manager if engine == "postgres" else state.mysql_container_manager
    endpoint = None
    if cm:
        endpoint = await cm.start_container(db_cluster_id)
    cluster = _DBCluster(
        db_cluster_identifier=db_cluster_id,
        engine=engine,
        master_username=body.get("MasterUsername", "admin"),
        data_plane_endpoint=endpoint,
    )
    state.clusters[db_cluster_id] = cluster

    return _json_response({"DBCluster": _format_db_cluster(cluster)})


async def _handle_describe_db_clusters(state: _RdsState, body: dict) -> Response:
    """Handle DescribeDBClusters."""
    db_cluster_id = body.get("DBClusterIdentifier")

    if db_cluster_id:
        cluster = state.clusters.get(db_cluster_id)
        if cluster is None:
            return _error_response(
                "DBClusterNotFoundFault",
                f"DB cluster not found: {db_cluster_id}",
                status_code=404,
            )
        return _json_response({"DBClusters": [_format_db_cluster(cluster)]})

    clusters = [_format_db_cluster(c) for c in state.clusters.values()]
    return _json_response({"DBClusters": clusters})


async def _handle_delete_db_cluster(state: _RdsState, body: dict) -> Response:
    """Handle DeleteDBCluster."""
    db_cluster_id = body.get("DBClusterIdentifier", "")

    cluster = state.clusters.get(db_cluster_id)
    if cluster is None:
        return _error_response(
            "DBClusterNotFoundFault",
            f"DB cluster not found: {db_cluster_id}",
            status_code=404,
        )

    del state.clusters[db_cluster_id]
    if cluster.engine == "postgres":
        cm = state.postgres_container_manager
    else:
        cm = state.mysql_container_manager
    if cm:
        await cm.stop_container(db_cluster_id)
    cluster.status = "deleting"
    return _json_response({"DBCluster": _format_db_cluster(cluster)})


async def _handle_list_tags_for_resource(state: _RdsState, body: dict) -> Response:
    """Handle ListTagsForResource."""
    resource_arn = body.get("ResourceName", "")

    tags = _find_resource_tags(state, resource_arn)
    if tags is None:
        return _error_response(
            "DBInstanceNotFoundFault",
            f"Resource not found: {resource_arn}",
            status_code=404,
        )

    tag_list = [{"Key": k, "Value": v} for k, v in tags.items()]
    return _json_response({"TagList": tag_list})


async def _handle_add_tags_to_resource(state: _RdsState, body: dict) -> Response:
    """Handle AddTagsToResource."""
    resource_arn = body.get("ResourceName", "")
    new_tags = body.get("Tags", [])

    tags = _find_resource_tags(state, resource_arn)
    if tags is None:
        return _error_response(
            "DBInstanceNotFoundFault",
            f"Resource not found: {resource_arn}",
            status_code=404,
        )

    for tag in new_tags:
        tags[tag["Key"]] = tag["Value"]

    return _json_response({})


async def _handle_remove_tags_from_resource(state: _RdsState, body: dict) -> Response:
    """Handle RemoveTagsFromResource."""
    resource_arn = body.get("ResourceName", "")
    tag_keys = body.get("TagKeys", [])

    tags = _find_resource_tags(state, resource_arn)
    if tags is None:
        return _error_response(
            "DBInstanceNotFoundFault",
            f"Resource not found: {resource_arn}",
            status_code=404,
        )

    for key in tag_keys:
        tags.pop(key, None)

    return _json_response({})


async def _handle_describe_db_engine_versions(_state: _RdsState, body: dict) -> Response:
    """Handle DescribeDBEngineVersions."""
    engine = body.get("Engine")

    if engine:
        versions = _ENGINE_VERSIONS.get(engine, [])
    else:
        versions = []
        for engine_versions in _ENGINE_VERSIONS.values():
            versions.extend(engine_versions)

    return _json_response({"DBEngineVersions": versions})


# ------------------------------------------------------------------
# Action dispatch table
# ------------------------------------------------------------------


_ACTION_HANDLERS: dict[str, Any] = {
    "CreateDBInstance": _handle_create_db_instance,
    "DescribeDBInstances": _handle_describe_db_instances,
    "DeleteDBInstance": _handle_delete_db_instance,
    "ModifyDBInstance": _handle_modify_db_instance,
    "CreateDBCluster": _handle_create_db_cluster,
    "DescribeDBClusters": _handle_describe_db_clusters,
    "DeleteDBCluster": _handle_delete_db_cluster,
    "ListTagsForResource": _handle_list_tags_for_resource,
    "AddTagsToResource": _handle_add_tags_to_resource,
    "RemoveTagsFromResource": _handle_remove_tags_from_resource,
    "DescribeDBEngineVersions": _handle_describe_db_engine_versions,
}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_rds_app(
    *,
    postgres_container_manager: ResourceContainerManager | None = None,
    mysql_container_manager: ResourceContainerManager | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the RDS wire protocol."""
    app = FastAPI(title="LDK RDS")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="rds")
    state = _RdsState(
        postgres_container_manager=postgres_container_manager,
        mysql_container_manager=mysql_container_manager,
    )

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        target = request.headers.get("x-amz-target", "")
        body = await parse_json_body(request)
        action = resolve_api_action(target, body)

        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            _logger.warning("Unknown RDS action: %s", action)
            return _error_response(
                "InvalidAction",
                f"lws: RDS operation '{action}' is not yet implemented",
            )

        return await handler(state, body)

    return app
