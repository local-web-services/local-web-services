"""S3 Tables route handler functions."""

from __future__ import annotations

import json

from fastapi import Request, Response

from lws.providers.s3tables._s3tables_state import (
    _Namespace,
    _S3TablesState,
    _Table,
    _TableBucket,
)


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON response."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/json",
    )


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response."""
    error_body = {"__type": code, "message": message}
    return _json_response(error_body, status_code=status_code)


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

    return Response(status_code=204)


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

    return Response(status_code=204)


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

    return Response(status_code=204)
