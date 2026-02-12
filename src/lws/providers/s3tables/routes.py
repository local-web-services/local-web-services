"""FastAPI routes implementing the S3 Tables REST API for local development.

Provides in-memory emulation of the AWS S3 Tables service including
table buckets, namespaces, and tables.
"""

from __future__ import annotations

import json
from datetime import UTC, datetime

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware

_logger = get_logger("ldk.s3tables")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# JSON helpers
# ------------------------------------------------------------------


def _json_response(data: dict, status_code: int = 200) -> Response:
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/json",
    )


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    error_body = {"__type": code, "message": message}
    return _json_response(error_body, status_code=status_code)


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _Table:
    """Represents a single table within a namespace."""

    def __init__(self, name: str, namespace: str, table_bucket_arn: str, fmt: str) -> None:
        self.name = name
        self.namespace = namespace
        self.table_bucket_arn = table_bucket_arn
        self.format = fmt
        self.arn = f"{table_bucket_arn}/table/{namespace}/{name}"
        self.created_date = datetime.now(UTC).isoformat()


class _Namespace:
    """Represents a namespace within a table bucket."""

    def __init__(self, namespace: list[str], table_bucket_arn: str) -> None:
        self.namespace = namespace
        self.table_bucket_arn = table_bucket_arn
        self.created_date = datetime.now(UTC).isoformat()
        self.tables: dict[str, _Table] = {}


class _TableBucket:
    """Represents a table bucket."""

    def __init__(self, name: str) -> None:
        self.name = name
        self.arn = f"arn:aws:s3tables:{_REGION}:{_ACCOUNT_ID}:bucket/{name}"
        self.created_date = datetime.now(UTC).isoformat()
        self.namespaces: dict[str, _Namespace] = {}


class _S3TablesState:
    """In-memory store for all S3 Tables resources."""

    def __init__(self) -> None:
        self.table_buckets: dict[str, _TableBucket] = {}


# ------------------------------------------------------------------
# Route handlers — Table Buckets
# ------------------------------------------------------------------


async def _create_table_bucket(request: Request, state: _S3TablesState) -> Response:
    """Handle CreateTableBucket (PUT /table-buckets)."""
    try:
        body = await request.json()
    except Exception:
        return _error_response("BadRequestException", "Invalid JSON body")

    name = body.get("name", "")
    if not name:
        return _error_response("BadRequestException", "Table bucket name is required")

    if name in state.table_buckets:
        return _error_response(
            "ConflictException",
            f"Table bucket '{name}' already exists",
            status_code=409,
        )

    bucket = _TableBucket(name)
    state.table_buckets[name] = bucket
    _logger.info("Created table bucket: %s", name)

    return _json_response(
        {
            "tableBucketARN": bucket.arn,
        },
        status_code=200,
    )


async def _list_table_buckets(state: _S3TablesState) -> Response:
    """Handle ListTableBuckets (GET /table-buckets)."""
    buckets = []
    for bucket in state.table_buckets.values():
        buckets.append(
            {
                "name": bucket.name,
                "tableBucketARN": bucket.arn,
                "createdAt": bucket.created_date,
            }
        )

    return _json_response({"tableBuckets": buckets})


async def _get_table_bucket(table_bucket_arn: str, state: _S3TablesState) -> Response:
    """Handle GetTableBucket (GET /table-buckets/{tableBucketARN})."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    return _json_response(
        {
            "name": bucket.name,
            "tableBucketARN": bucket.arn,
            "createdAt": bucket.created_date,
        }
    )


async def _delete_table_bucket(table_bucket_arn: str, state: _S3TablesState) -> Response:
    """Handle DeleteTableBucket (DELETE /table-buckets/{tableBucketARN})."""
    bucket = state.table_buckets.pop(table_bucket_arn, None)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    _logger.info("Deleted table bucket: %s", table_bucket_arn)
    return Response(status_code=204)


# ------------------------------------------------------------------
# Route handlers — Namespaces
# ------------------------------------------------------------------


async def _create_namespace(
    table_bucket_arn: str, request: Request, state: _S3TablesState
) -> Response:
    """Handle CreateNamespace (PUT /table-buckets/{tableBucketARN}/namespaces)."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    try:
        body = await request.json()
    except Exception:
        return _error_response("BadRequestException", "Invalid JSON body")

    namespace_list = body.get("namespace", [])
    if not namespace_list or not isinstance(namespace_list, list) or len(namespace_list) == 0:
        return _error_response("BadRequestException", "Namespace is required")

    ns_name = namespace_list[0]
    if ns_name in bucket.namespaces:
        return _error_response(
            "ConflictException",
            f"Namespace '{ns_name}' already exists in table bucket '{table_bucket_arn}'",
            status_code=409,
        )

    namespace = _Namespace(namespace_list, bucket.arn)
    bucket.namespaces[ns_name] = namespace
    _logger.info("Created namespace '%s' in table bucket '%s'", ns_name, table_bucket_arn)

    return _json_response(
        {
            "namespace": namespace.namespace,
            "tableBucketARN": bucket.arn,
        },
        status_code=200,
    )


async def _list_namespaces(table_bucket_arn: str, state: _S3TablesState) -> Response:
    """Handle ListNamespaces (GET /table-buckets/{tableBucketARN}/namespaces)."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    namespaces = []
    for ns in bucket.namespaces.values():
        namespaces.append(
            {
                "namespace": ns.namespace,
                "createdAt": ns.created_date,
            }
        )

    return _json_response({"namespaces": namespaces})


async def _get_namespace(table_bucket_arn: str, namespace: str, state: _S3TablesState) -> Response:
    """Handle GetNamespace (GET /table-buckets/{tableBucketARN}/namespaces/{namespace})."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    ns = bucket.namespaces.get(namespace)
    if ns is None:
        return _error_response(
            "NotFoundException",
            f"Namespace '{namespace}' not found in table bucket '{table_bucket_arn}'",
            status_code=404,
        )

    return _json_response(
        {
            "namespace": ns.namespace,
            "tableBucketARN": bucket.arn,
            "createdAt": ns.created_date,
        }
    )


async def _delete_namespace(
    table_bucket_arn: str, namespace: str, state: _S3TablesState
) -> Response:
    """Handle DeleteNamespace (DELETE /table-buckets/{tableBucketARN}/namespaces/{namespace})."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    ns = bucket.namespaces.pop(namespace, None)
    if ns is None:
        return _error_response(
            "NotFoundException",
            f"Namespace '{namespace}' not found in table bucket '{table_bucket_arn}'",
            status_code=404,
        )

    _logger.info("Deleted namespace '%s' from table bucket '%s'", namespace, table_bucket_arn)
    return Response(status_code=204)


# ------------------------------------------------------------------
# Route handlers — Tables
# ------------------------------------------------------------------


async def _create_table(
    table_bucket_arn: str, namespace: str, request: Request, state: _S3TablesState
) -> Response:
    """Handle CreateTable (PUT /table-buckets/{tableBucketARN}/namespaces/{namespace}/tables)."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    ns = bucket.namespaces.get(namespace)
    if ns is None:
        return _error_response(
            "NotFoundException",
            f"Namespace '{namespace}' not found in table bucket '{table_bucket_arn}'",
            status_code=404,
        )

    try:
        body = await request.json()
    except Exception:
        return _error_response("BadRequestException", "Invalid JSON body")

    name = body.get("name", "")
    fmt = body.get("format", "ICEBERG")

    if not name:
        return _error_response("BadRequestException", "Table name is required")

    if name in ns.tables:
        return _error_response(
            "ConflictException",
            f"Table '{name}' already exists in namespace '{namespace}'",
            status_code=409,
        )

    table = _Table(name, namespace, bucket.arn, fmt)
    ns.tables[name] = table
    _logger.info(
        "Created table '%s' in namespace '%s' of table bucket '%s'",
        name,
        namespace,
        table_bucket_arn,
    )

    return _json_response(
        {
            "tableARN": table.arn,
        },
        status_code=200,
    )


async def _list_tables(table_bucket_arn: str, namespace: str, state: _S3TablesState) -> Response:
    """Handle ListTables (GET /table-buckets/{tableBucketARN}/namespaces/{namespace}/tables)."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    ns = bucket.namespaces.get(namespace)
    if ns is None:
        return _error_response(
            "NotFoundException",
            f"Namespace '{namespace}' not found in table bucket '{table_bucket_arn}'",
            status_code=404,
        )

    tables = []
    for table in ns.tables.values():
        tables.append(
            {
                "name": table.name,
                "namespace": [table.namespace],
                "tableARN": table.arn,
                "createdAt": table.created_date,
            }
        )

    return _json_response({"tables": tables})


async def _get_table(
    table_bucket_arn: str, namespace: str, table_name: str, state: _S3TablesState
) -> Response:
    """Handle GetTable."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    ns = bucket.namespaces.get(namespace)
    if ns is None:
        return _error_response(
            "NotFoundException",
            f"Namespace '{namespace}' not found in table bucket '{table_bucket_arn}'",
            status_code=404,
        )

    table = ns.tables.get(table_name)
    if table is None:
        return _error_response(
            "NotFoundException",
            f"Table '{table_name}' not found in namespace '{namespace}'",
            status_code=404,
        )

    return _json_response(
        {
            "name": table.name,
            "namespace": [table.namespace],
            "tableBucketARN": table.table_bucket_arn,
            "tableARN": table.arn,
            "format": table.format,
            "createdAt": table.created_date,
        }
    )


async def _delete_table(
    table_bucket_arn: str, namespace: str, table_name: str, state: _S3TablesState
) -> Response:
    """Handle DeleteTable."""
    bucket = state.table_buckets.get(table_bucket_arn)
    if bucket is None:
        return _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )

    ns = bucket.namespaces.get(namespace)
    if ns is None:
        return _error_response(
            "NotFoundException",
            f"Namespace '{namespace}' not found in table bucket '{table_bucket_arn}'",
            status_code=404,
        )

    table = ns.tables.pop(table_name, None)
    if table is None:
        return _error_response(
            "NotFoundException",
            f"Table '{table_name}' not found in namespace '{namespace}'",
            status_code=404,
        )

    _logger.info(
        "Deleted table '%s' from namespace '%s' of table bucket '%s'",
        table_name,
        namespace,
        table_bucket_arn,
    )
    return Response(status_code=204)


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def _register_bucket_routes(app: FastAPI, state: _S3TablesState) -> None:
    """Register table bucket CRUD routes."""

    @app.put("/table-buckets")
    async def create_table_bucket(request: Request) -> Response:
        return await _create_table_bucket(request, state)

    @app.get("/table-buckets")
    async def list_table_buckets() -> Response:
        return await _list_table_buckets(state)

    @app.get("/table-buckets/{tableBucketARN}")
    async def get_table_bucket(tableBucketARN: str) -> Response:
        return await _get_table_bucket(tableBucketARN, state)

    @app.delete("/table-buckets/{tableBucketARN}")
    async def delete_table_bucket(tableBucketARN: str) -> Response:
        return await _delete_table_bucket(tableBucketARN, state)


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


def create_s3tables_app() -> FastAPI:
    """Create a FastAPI application that speaks the S3 Tables REST API."""
    app = FastAPI(title="LDK S3 Tables")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="s3tables")
    state = _S3TablesState()

    _register_bucket_routes(app, state)
    _register_namespace_routes(app, state)
    _register_table_routes(app, state)

    return app
