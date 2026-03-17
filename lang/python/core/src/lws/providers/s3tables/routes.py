"""FastAPI routes implementing the S3 Tables REST API for local development.

Provides in-memory emulation of the AWS S3 Tables service including
table buckets, namespaces, and tables.
"""

from __future__ import annotations

import json

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers.s3tables._s3tables_handlers import (
    _create_namespace,
    _create_table,
    _create_table_bucket,
    _delete_namespace,
    _delete_table,
    _delete_table_bucket,
    _error_response,
    _get_namespace,
    _get_table,
    _get_table_bucket,
    _list_namespaces,
    _list_table_buckets,
    _list_tables,
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
    if lc.enabled and lc.create_dwell_ms > 0:
        try:
            raw = await request.body()
            bucket_name = json.loads(raw).get("name", "")
        except Exception:
            bucket_name = ""
    resp = await _create_table_bucket(request, state)
    if lc.enabled and resp.status_code == 200 and lc.create_dwell_ms > 0 and bucket_name:
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
    if lc.enabled and tracker.get_state(table_bucket_arn) == "CREATING":
        return _error_response(
            "ConflictException",
            f"Table bucket '{table_bucket_arn}' is still being created",
            status_code=409,
        )
    resp = await _delete_table_bucket(table_bucket_arn, state)
    if lc.enabled and resp.status_code == 204:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(table_bucket_arn, "DELETING")
            tracker.schedule_transition(table_bucket_arn, None, lc.delete_dwell_ms)
        else:
            tracker.remove(table_bucket_arn)
    return resp


def _register_bucket_routes(
    app: FastAPI, state: _S3TablesState, tracker: ResourceStateTracker, lc: ResourceLifecycleConfig
) -> None:
    """Register table bucket CRUD routes."""

    @app.put("/table-buckets")
    async def create_table_bucket(request: Request) -> Response:
        return await _s3tables_create_table_bucket(request, state, lc, tracker)

    @app.get("/table-buckets")
    async def list_table_buckets() -> Response:
        return await _list_table_buckets(state)

    @app.get("/table-buckets/{tableBucketARN}")
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

    @app.delete("/table-buckets/{tableBucketARN}")
    async def delete_table_bucket(tableBucketARN: str) -> Response:
        return await _s3tables_delete_table_bucket(tableBucketARN, state, lc, tracker)


def _register_namespace_routes(app: FastAPI, state: _S3TablesState) -> None:
    """Register namespace CRUD routes."""

    @app.put("/table-buckets/{tableBucketARN}/namespaces")
    async def create_namespace(tableBucketARN: str, request: Request) -> Response:
        return await _create_namespace(tableBucketARN, request, state)

    @app.get("/table-buckets/{tableBucketARN}/namespaces")
    async def list_namespaces(tableBucketARN: str) -> Response:
        return await _list_namespaces(tableBucketARN, state)

    @app.get("/table-buckets/{tableBucketARN}/namespaces/{namespace}")
    async def get_namespace(tableBucketARN: str, namespace: str) -> Response:
        return await _get_namespace(tableBucketARN, namespace, state)

    @app.delete("/table-buckets/{tableBucketARN}/namespaces/{namespace}")
    async def delete_namespace(tableBucketARN: str, namespace: str) -> Response:
        return await _delete_namespace(tableBucketARN, namespace, state)


def _register_table_routes(app: FastAPI, state: _S3TablesState) -> None:
    """Register table CRUD routes."""

    @app.put("/table-buckets/{tableBucketARN}/namespaces/{namespace}/tables")
    async def create_table(tableBucketARN: str, namespace: str, request: Request) -> Response:
        return await _create_table(tableBucketARN, namespace, request, state)

    @app.get("/table-buckets/{tableBucketARN}/namespaces/{namespace}/tables")
    async def list_tables(tableBucketARN: str, namespace: str) -> Response:
        return await _list_tables(tableBucketARN, namespace, state)

    @app.get("/table-buckets/{tableBucketARN}/namespaces/{namespace}/tables/{tableName}")
    async def get_table(tableBucketARN: str, namespace: str, tableName: str) -> Response:
        return await _get_table(tableBucketARN, namespace, tableName, state)

    @app.delete("/table-buckets/{tableBucketARN}/namespaces/{namespace}/tables/{tableName}")
    async def delete_table(tableBucketARN: str, namespace: str, tableName: str) -> Response:
        return await _delete_table(tableBucketARN, namespace, tableName, state)


def create_s3tables_app(lifecycle: ResourceLifecycleConfig | None = None) -> FastAPI:
    """Create a FastAPI application that speaks the S3 Tables REST API."""
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)

    app = FastAPI(title="LDK S3 Tables")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="s3tables")
    state = _S3TablesState()

    _register_bucket_routes(app, state, _tracker, _lc)
    _register_namespace_routes(app, state)
    _register_table_routes(app, state)

    return app
