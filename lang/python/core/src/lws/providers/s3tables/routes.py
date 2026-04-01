"""FastAPI routes implementing the S3 Tables REST API for local development.

Provides in-memory emulation of the AWS S3 Tables service including
table buckets, namespaces, and tables.
"""

from __future__ import annotations

import json

from fastapi import FastAPI, Query, Request, Response

from lws.interfaces.cloudtrail import ICloudTrail  # noqa: TC001
from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    TrackerRegistry,
    register_tracker,
)
from lws.providers.s3tables._s3tables_handlers import (
    _create_namespace,
    _create_table,
    _create_table_bucket,
    _delete_namespace,
    _delete_table,
    _delete_table_bucket,
    _delete_table_policy,
    _error_response,
    _get_namespace,
    _get_table,
    _get_table_bucket,
    _list_namespaces,
    _list_table_buckets,
    _list_tables,
    _put_table_policy,
)
from lws.providers.s3tables._s3tables_maintenance_handlers import (
    _get_table_maintenance_configuration,
    _put_table_maintenance_configuration,
    _start_table_bucket_maintenance,
)
from lws.providers.s3tables._s3tables_state import _S3TablesState

_logger = get_logger("ldk.s3tables")


# ------------------------------------------------------------------
# App factory helpers
# ------------------------------------------------------------------


async def _s3tables_create_table_bucket(
    request: Request,
    state: _S3TablesState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware CreateTableBucket."""
    bucket_name = ""
    if lc.enabled:
        try:
            raw = await request.body()
            bucket_name = json.loads(raw).get("name", "")
        except Exception:
            bucket_name = ""
    resp = await _create_table_bucket(request, state)
    if lc.enabled and resp.status_code == 200 and bucket_name:
        tracker.set_state(bucket_name, "CREATING")
        tracker.schedule_transition(bucket_name, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _s3tables_delete_table_bucket(
    table_bucket_arn: str,
    state: _S3TablesState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteTableBucket."""
    bucket_name = table_bucket_arn.rsplit("/", 1)[-1]
    if lc.enabled and tracker.get_state(bucket_name) == "CREATING":
        return _error_response(
            "ConflictException",
            f"Table bucket '{table_bucket_arn}' is still being created",
            status_code=409,
        )
    resp = await _delete_table_bucket(table_bucket_arn, state)
    if lc.enabled and resp.status_code == 204:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(bucket_name, "DELETING")
            tracker.schedule_transition(bucket_name, None, lc.delete_dwell_ms)
        else:
            tracker.remove(bucket_name)
    return resp


def _ns_tracker_key(bucket_arn: str, namespace: str) -> str:
    return f"{bucket_arn}#{namespace}"


def _table_tracker_key(bucket_arn: str, namespace: str, name: str) -> str:
    return f"{bucket_arn}/table/{namespace}/{name}"


async def _s3tables_create_namespace(
    table_bucket_arn: str,
    request: Request,
    state: _S3TablesState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware CreateNamespace."""
    ns_name = ""
    if lc.enabled:
        try:
            raw = await request.body()
            namespaces = json.loads(raw).get("namespace", [])
            ns_name = namespaces[0] if namespaces else ""
        except Exception:
            ns_name = ""
    resp = await _create_namespace(table_bucket_arn, request, state)
    if lc.enabled and resp.status_code == 200 and ns_name:
        key = _ns_tracker_key(table_bucket_arn, ns_name)
        tracker.set_state(key, "CREATING")
        tracker.schedule_transition(key, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _s3tables_delete_namespace(
    table_bucket_arn: str,
    namespace: str,
    state: _S3TablesState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteNamespace."""
    if lc.enabled:
        key = _ns_tracker_key(table_bucket_arn, namespace)
        if tracker.get_state(key) == "CREATING":
            return _error_response(
                "ConflictException",
                f"Namespace '{namespace}' is still being created",
                status_code=409,
            )
    resp = await _delete_namespace(table_bucket_arn, namespace, state)
    if lc.enabled and resp.status_code == 204:
        key = _ns_tracker_key(table_bucket_arn, namespace)
        if lc.delete_dwell_ms > 0:
            tracker.set_state(key, "DELETING")
            tracker.schedule_transition(key, None, lc.delete_dwell_ms)
        else:
            tracker.remove(key)
    return resp


async def _s3tables_create_table(
    table_bucket_arn: str,
    namespace: str,
    request: Request,
    state: _S3TablesState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware CreateTable."""
    if lc.enabled:
        if tracker.get_state(table_bucket_arn) == "CREATING":
            return _error_response(
                "NotFoundException",
                f"Table bucket '{table_bucket_arn}' not found",
                status_code=404,
            )
        ns_key = _ns_tracker_key(table_bucket_arn, namespace)
        if tracker.get_state(ns_key) == "CREATING":
            return _error_response(
                "ConflictException",
                f"Namespace '{namespace}' is still being created",
                status_code=409,
            )
    table_name = ""
    if lc.enabled:
        try:
            raw = await request.body()
            table_name = json.loads(raw).get("name", "")
        except Exception:
            table_name = ""
    resp = await _create_table(table_bucket_arn, namespace, request, state)
    if lc.enabled and resp.status_code == 200 and table_name:
        key = _table_tracker_key(table_bucket_arn, namespace, table_name)
        tracker.set_state(key, "CREATING")
        tracker.schedule_transition(key, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _s3tables_delete_table(
    table_bucket_arn: str,
    namespace: str,
    table_name: str,
    state: _S3TablesState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteTable."""
    if lc.enabled:
        key = _table_tracker_key(table_bucket_arn, namespace, table_name)
        if tracker.get_state(key) == "CREATING":
            return _error_response(
                "ConflictException",
                f"Table '{table_name}' is still being created",
                status_code=409,
            )
    resp = await _delete_table(table_bucket_arn, namespace, table_name, state)
    if lc.enabled and resp.status_code == 204:
        key = _table_tracker_key(table_bucket_arn, namespace, table_name)
        if lc.delete_dwell_ms > 0:
            tracker.set_state(key, "DELETING")
            tracker.schedule_transition(key, None, lc.delete_dwell_ms)
        else:
            tracker.remove(key)
    return resp


async def _s3tables_put_table_policy(
    table_bucket_arn: str,
    namespace: str,
    table_name: str,
    request: Request,
    state: _S3TablesState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware PutTablePolicy."""
    if lc.enabled:
        key = _table_tracker_key(table_bucket_arn, namespace, table_name)
        if tracker.get_state(key) == "CREATING":
            return _error_response(
                "ConflictException",
                f"Table '{table_name}' is still being created",
                status_code=409,
            )
    return await _put_table_policy(table_bucket_arn, namespace, table_name, request, state)


async def _s3tables_put_table_maintenance_configuration(
    table_bucket_arn: str,
    namespace: str,
    table_name: str,
    maintenance_type: str,
    request: Request,
    state: _S3TablesState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware PutTableMaintenanceConfiguration."""
    if lc.enabled:
        key = _table_tracker_key(table_bucket_arn, namespace, table_name)
        if tracker.get_state(key) == "CREATING":
            return _error_response(
                "ConflictException",
                f"Table '{table_name}' is still being created",
                status_code=409,
            )
    return await _put_table_maintenance_configuration(
        table_bucket_arn, namespace, table_name, maintenance_type, request, state
    )


def _split_arn_and_suffix(path: str, n: int) -> tuple[str, ...]:
    """Split a decoded path into (tableBucketARN, *n_trailing_parts).

    ARN values like ``arn:aws:s3tables:us-east-1:000000000000:bucket/name``
    contain a literal slash which Starlette decodes from ``%2F`` before
    routing.  Using ``{param:path}`` captures everything including those
    slashes.  This helper then peels off the last ``n`` slash-delimited
    segments as the trailing parts (namespace, table name, etc.) and returns
    the remainder as the ARN.
    """
    parts = path.rsplit("/", n)
    if len(parts) != n + 1:
        return (path,) + ("",) * n
    return tuple(parts)


def _register_bucket_routes(
    app: FastAPI, state: _S3TablesState, tracker: ResourceStateTracker, lc: ResourceLifecycleConfig
) -> None:
    """Register table bucket CRUD routes."""

    @app.put("/buckets")
    async def create_table_bucket(request: Request) -> Response:
        return await _s3tables_create_table_bucket(request, state, lc, tracker)

    @app.get("/buckets")
    async def list_table_buckets() -> Response:
        return await _list_table_buckets(state)

    @app.get("/buckets/{tableBucketARN:path}")
    async def get_table_bucket(tableBucketARN: str) -> Response:
        if lc.enabled:
            bucket_state = tracker.get_state(tableBucketARN)
            if bucket_state in ("CREATING", "DELETING"):
                return _error_response(
                    "NotFoundException",
                    f"Table bucket '{tableBucketARN}' not found (status: {bucket_state})",
                    status_code=404,
                )
        return await _get_table_bucket(tableBucketARN, state)

    @app.delete("/buckets/{tableBucketARN:path}")
    async def delete_table_bucket(tableBucketARN: str) -> Response:
        return await _s3tables_delete_table_bucket(tableBucketARN, state, lc, tracker)

    @app.put("/buckets/{path:path}")
    async def bucket_maintenance_or_other(path: str, request: Request) -> Response:
        # PUT /buckets/{arn}/maintenance/{type} → start_table_bucket_maintenance
        if "/maintenance/" in path:
            parts = path.rsplit("/maintenance/", 1)
            bucket_arn, maintenance_type = parts[0], parts[1]
            return await _start_table_bucket_maintenance(
                bucket_arn, maintenance_type, request, state
            )
        return _error_response("BadRequestException", f"Unsupported bucket operation: {path}")


def _register_namespace_routes(
    app: FastAPI, state: _S3TablesState, tracker: ResourceStateTracker, lc: ResourceLifecycleConfig
) -> None:
    """Register namespace CRUD routes."""

    @app.put("/namespaces/{path:path}")
    async def create_namespace(path: str, request: Request) -> Response:
        tableBucketARN = path
        return await _s3tables_create_namespace(tableBucketARN, request, state, lc, tracker)

    @app.get("/namespaces/{path:path}")
    async def list_or_get_namespace(path: str) -> Response:
        # Distinguish GET /namespaces/{arn} (list) from GET /namespaces/{arn}/{ns} (get).
        #
        # ARN values start with "arn:" and contain exactly one slash
        # (the "bucket/<name>" portion).  A plain bucket name has no slashes.
        # A namespace name never contains a slash.
        #
        # Routing rules:
        #   path starts with "arn:" and has 1 slash  → bare ARN → ListNamespaces
        #   path starts with "arn:" and has 2 slashes → ARN + namespace → GetNamespace
        #   path has 0 slashes (simple name)           → ListNamespaces
        #   path has 1 slash  (simple-name/namespace)  → GetNamespace
        slash_count = path.count("/")
        is_arn = path.startswith("arn:")
        arn_bare_slashes = 1  # a bare ARN has exactly one slash
        if (is_arn and slash_count > arn_bare_slashes) or (not is_arn and slash_count > 0):
            tableBucketARN, namespace = _split_arn_and_suffix(path, 1)[:2]
            return await _get_namespace(tableBucketARN, namespace, state)
        return await _list_namespaces(path, state)

    @app.delete("/namespaces/{path:path}")
    async def delete_namespace(path: str) -> Response:
        tableBucketARN, namespace = _split_arn_and_suffix(path, 1)[:2]
        return await _s3tables_delete_namespace(tableBucketARN, namespace, state, lc, tracker)


def _register_table_routes(
    app: FastAPI, state: _S3TablesState, tracker: ResourceStateTracker, lc: ResourceLifecycleConfig
) -> None:
    """Register table CRUD routes."""

    @app.put("/tables/{path:path}")
    async def create_or_put_policy(path: str, request: Request) -> Response:
        # PUT /tables/{arn}/{ns}                      → create_table
        # PUT /tables/{arn}/{ns}/{name}/policy         → put_table_policy
        # PUT /tables/{arn}/{ns}/{name}/maintenance/{t} → put_table_maintenance_configuration
        if "/maintenance/" in path:
            parts = path.rsplit("/maintenance/", 1)
            inner, maintenance_type = parts[0], parts[1]
            tableBucketARN, namespace, name = _split_arn_and_suffix(inner, 2)[:3]
            return await _s3tables_put_table_maintenance_configuration(
                tableBucketARN, namespace, name, maintenance_type, request, state, lc, tracker
            )
        if path.endswith("/policy"):
            inner = path[: -len("/policy")]
            tableBucketARN, namespace, name = _split_arn_and_suffix(inner, 2)[:3]
            return await _s3tables_put_table_policy(
                tableBucketARN, namespace, name, request, state, lc, tracker
            )
        tableBucketARN, namespace = _split_arn_and_suffix(path, 1)[:2]
        return await _s3tables_create_table(tableBucketARN, namespace, request, state, lc, tracker)

    @app.get("/tables/{tableBucketARN:path}")
    async def list_tables(tableBucketARN: str, namespace: str = Query(default=None)) -> Response:
        # GET /tables/{arn}/{ns}/{name}/maintenance/{type} → get_table_maintenance_configuration
        if "/maintenance/" in tableBucketARN:
            parts = tableBucketARN.rsplit("/maintenance/", 1)
            inner, maintenance_type = parts[0], parts[1]
            table_bucket_arn, ns, name = _split_arn_and_suffix(inner, 2)[:3]
            return await _get_table_maintenance_configuration(
                table_bucket_arn, ns, name, maintenance_type, state
            )
        return await _list_tables(tableBucketARN, namespace, state)

    @app.get("/get-table")
    async def get_table(
        tableBucketARN: str = Query(...),
        namespace: str = Query(...),
        name: str = Query(...),
    ) -> Response:
        return await _get_table(tableBucketARN, namespace, name, state)

    @app.delete("/tables/{path:path}")
    async def delete_table_or_policy(path: str) -> Response:
        # DELETE /tables/{arn}/{ns}/{name}/policy → delete_table_policy
        # DELETE /tables/{arn}/{ns}/{name}         → delete_table
        if path.endswith("/policy"):
            inner = path[: -len("/policy")]
            tableBucketARN, namespace, name = _split_arn_and_suffix(inner, 2)[:3]
            return await _delete_table_policy(tableBucketARN, namespace, name, state)
        tableBucketARN, namespace, name = _split_arn_and_suffix(path, 2)[:3]
        return await _s3tables_delete_table(tableBucketARN, namespace, name, state, lc, tracker)


def create_s3tables_app(
    lifecycle: ResourceLifecycleConfig | None = None,
    registry: TrackerRegistry | None = None,
    cloudtrail_provider: ICloudTrail | None = None,
) -> tuple[FastAPI, _S3TablesState]:
    """Create a FastAPI application that speaks the S3 Tables REST API."""
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)
    if registry is not None:
        register_tracker(registry, "s3tables", "bucket", _tracker)
        register_tracker(registry, "s3tables", "namespace", _tracker)
        register_tracker(registry, "s3tables", "table", _tracker)

    app = FastAPI(title="LDK S3 Tables")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="s3tables")
    state = _S3TablesState()

    _register_bucket_routes(app, state, _tracker, _lc)
    _register_namespace_routes(app, state, _tracker, _lc)
    _register_table_routes(app, state, _tracker, _lc)

    apply_cloudtrail_middleware(app, cloudtrail_provider, "s3tables")
    return app, state
