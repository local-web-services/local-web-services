"""FastAPI route definitions for ECS service management.

Provides routes for querying ECS service status, triggering restarts,
and inspecting the service discovery registry.

Also provides ``create_ecs_app`` — a FastAPI application that speaks the
AWS ECS JSON wire protocol for cluster lifecycle management.
"""

from __future__ import annotations

from typing import Any

from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.response_helpers import json_response as _json_response
from lws.providers.ecs.discovery import ServiceRegistry

_logger = get_logger("ldk.ecs")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"

router = APIRouter(prefix="/ecs", tags=["ecs"])


def build_ecs_router(registry: ServiceRegistry) -> APIRouter:
    """Create an API router that exposes ECS service management endpoints.

    Args:
        registry: The service discovery registry to query.

    Returns:
        A FastAPI ``APIRouter`` with ECS management routes.
    """
    ecs_router = APIRouter(prefix="/ecs", tags=["ecs"])

    @ecs_router.get("/services")
    async def list_services() -> dict:
        endpoints = registry.all_endpoints()
        services = []
        for name, ep in endpoints.items():
            services.append(
                {
                    "service_name": name,
                    "host": ep.host,
                    "port": ep.port,
                    "url": ep.url,
                }
            )
        return {"services": services}

    @ecs_router.get("/services/{service_name}")
    async def get_service(service_name: str) -> dict:
        ep = registry.lookup(service_name)
        if ep is None:
            return {"error": f"Service '{service_name}' not found"}
        return {
            "service_name": ep.service_name,
            "host": ep.host,
            "port": ep.port,
            "url": ep.url,
        }

    return ecs_router


# ------------------------------------------------------------------
# AWS ECS wire-protocol: in-memory state
# ------------------------------------------------------------------


class _Cluster:
    """Represents an ECS cluster."""

    def __init__(self, cluster_name: str) -> None:
        self.cluster_name = cluster_name
        self.cluster_arn = f"arn:aws:ecs:{_REGION}:{_ACCOUNT_ID}:cluster/{cluster_name}"
        self.status = "ACTIVE"

    def to_dict(self) -> dict[str, Any]:
        """Serialize to the AWS response shape."""
        return {
            "clusterArn": self.cluster_arn,
            "clusterName": self.cluster_name,
            "status": self.status,
        }


class _EcsState:
    """In-memory store for ECS clusters."""

    def __init__(self) -> None:
        self._clusters: dict[str, _Cluster] = {}

    @property
    def clusters(self) -> dict[str, _Cluster]:
        """Return the clusters store."""
        return self._clusters


# ------------------------------------------------------------------
# AWS ECS wire-protocol: route handlers
# ------------------------------------------------------------------


def _error_response_ecs(code: str, message: str, status_code: int = 400) -> Response:
    """Return an ECS-style JSON error response."""
    return Response(
        content=f'{{"__type":"{code}","message":"{message}"}}',
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


async def _handle_create_cluster(state: _EcsState, body: dict) -> Response:
    """Handle CreateCluster."""
    cluster_name = body.get("clusterName", "default")
    if cluster_name not in state.clusters:
        state.clusters[cluster_name] = _Cluster(cluster_name)
    return _json_response({"cluster": state.clusters[cluster_name].to_dict()})


async def _handle_delete_cluster(state: _EcsState, body: dict) -> Response:
    """Handle DeleteCluster."""
    cluster = body.get("cluster", "")
    # Accept both name and ARN
    cluster_name = cluster.rsplit("/", 1)[-1] if "/" in cluster else cluster
    obj = state.clusters.pop(cluster_name, None)
    if obj is None:
        return _error_response_ecs(
            "ClusterNotFoundException",
            "The specified cluster was not found.",
            status_code=400,
        )
    obj.status = "INACTIVE"
    return _json_response({"cluster": obj.to_dict()})


async def _handle_describe_clusters(state: _EcsState, body: dict) -> Response:
    """Handle DescribeClusters."""
    requested: list[str] = body.get("clusters", [])
    if not requested:
        # Return all clusters when none specified
        cluster_list = [c.to_dict() for c in state.clusters.values()]
        return _json_response({"clusters": cluster_list, "failures": []})

    found = []
    failures = []
    for ref in requested:
        cluster_name = ref.rsplit("/", 1)[-1] if "/" in ref else ref
        obj = state.clusters.get(cluster_name)
        if obj is not None:
            found.append(obj.to_dict())
        else:
            failures.append(
                {
                    "arn": ref,
                    "reason": "MISSING",
                    "detail": f"Cluster not found: {ref}",
                }
            )
    return _json_response({"clusters": found, "failures": failures})


async def _handle_list_clusters(state: _EcsState, _body: dict | None = None) -> Response:
    """Handle ListClusters."""
    arns = [c.cluster_arn for c in state.clusters.values()]
    return _json_response({"clusterArns": arns})


_TARGET_HANDLERS = {
    "AmazonEC2ContainerServiceV20141113.CreateCluster": _handle_create_cluster,
    "AmazonEC2ContainerServiceV20141113.DeleteCluster": _handle_delete_cluster,
    "AmazonEC2ContainerServiceV20141113.DescribeClusters": _handle_describe_clusters,
    "AmazonEC2ContainerServiceV20141113.ListClusters": _handle_list_clusters,
}


# ------------------------------------------------------------------
# AWS ECS wire-protocol: app factory
# ------------------------------------------------------------------


async def _lifecycle_describe_clusters(
    body: dict,
    _lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Return an error response if any requested cluster is in a transient state."""
    requested: list[str] = body.get("clusters", [])
    for ref in requested:
        cluster_name = ref.rsplit("/", 1)[-1] if "/" in ref else ref
        cluster_state = tracker.get_state(cluster_name)
        if cluster_state in ("CREATING", "DELETING"):
            failures = [
                {
                    "arn": ref,
                    "reason": "MISSING",
                    "detail": f"Cluster not found: {ref} (status: {cluster_state})",
                }
            ]
            return _json_response({"clusters": [], "failures": failures})
    return None


async def _lifecycle_create_cluster(
    state: _EcsState,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware CreateCluster."""
    resp = await _handle_create_cluster(state, body)
    if resp.status_code == 200 and lc.create_dwell_ms > 0:
        cluster_name = body.get("clusterName", "default")
        tracker.set_state(cluster_name, "CREATING")
        tracker.schedule_transition(cluster_name, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _lifecycle_delete_cluster(
    state: _EcsState,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteCluster."""
    cluster = body.get("cluster", "")
    cluster_name = cluster.rsplit("/", 1)[-1] if "/" in cluster else cluster
    if tracker.get_state(cluster_name) == "CREATING":
        return _error_response_ecs(
            "ClusterContainsContainerInstancesException",
            f"Cluster {cluster_name} is still being created",
        )
    resp = await _handle_delete_cluster(state, body)
    if resp.status_code == 200:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(cluster_name, "DELETING")
            tracker.schedule_transition(cluster_name, None, lc.delete_dwell_ms)
        else:
            tracker.remove(cluster_name)
    return resp


def create_ecs_app(lifecycle: ResourceLifecycleConfig | None = None) -> FastAPI:
    """Create a FastAPI application that speaks the ECS JSON wire protocol."""
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)

    app = FastAPI(title="LDK ECS")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="ecs")
    state = _EcsState()

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        target = request.headers.get("X-Amz-Target", "")
        try:
            body: dict = await request.json()
        except Exception:
            body = {}

        if _lc.enabled and target.endswith(".DescribeClusters"):
            err = await _lifecycle_describe_clusters(body, _lc, _tracker)
            if err is not None:
                return err

        handler = _TARGET_HANDLERS.get(target)
        if handler is None:
            _logger.warning("Unknown ECS target: %s", target)
            return _error_response_ecs(
                "InvalidAction",
                f"lws: ECS operation '{target}' is not yet implemented",
            )

        if _lc.enabled and target.endswith(".CreateCluster"):
            return await _lifecycle_create_cluster(state, body, _lc, _tracker)

        if _lc.enabled and target.endswith(".DeleteCluster"):
            return await _lifecycle_delete_cluster(state, body, _lc, _tracker)

        return await handler(state, body)

    return app
