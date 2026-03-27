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


def _lookup_bucket(table_bucket_arn: str, state: _S3TablesState):  # type: ignore[return]
    """Return (bucket, None) or (None, error_response) for the given ARN."""
    bucket = state.get_bucket(table_bucket_arn)
    if bucket is None:
        return None, _error_response(
            "NotFoundException",
            f"Table bucket '{table_bucket_arn}' not found",
            status_code=404,
        )
    return bucket, None


def _lookup_namespace(bucket, namespace: str):  # type: ignore[return]
    """Return (namespace, None) or (None, error_response) for the given namespace name."""
    ns = bucket.namespaces.get(namespace)
    if ns is None:
        return None, _error_response(
            "NotFoundException",
            f"Namespace '{namespace}' not found",
            status_code=404,
        )
    return ns, None


def _lookup_bucket_ns(  # type: ignore[return]
    table_bucket_arn: str, namespace: str, state: _S3TablesState
):
    """Return (bucket, ns, None) or (None, None, error_response)."""
    bucket, err = _lookup_bucket(table_bucket_arn, state)
    if err is not None:
        return None, None, err
    ns, err = _lookup_namespace(bucket, namespace)
    if err is not None:
        return None, None, err
    return bucket, ns, None


def _lookup_bucket_ns_table(  # type: ignore[return]
    table_bucket_arn: str, namespace: str, name: str, state: _S3TablesState
):
    """Return (bucket, ns, table, None) or (None, None, None, error_response)."""
    bucket, ns, err = _lookup_bucket_ns(table_bucket_arn, namespace, state)
    if err is not None:
        return None, None, None, err
    table = ns.tables.get(name)
    if table is None:
        return (
            None,
            None,
            None,
            _error_response(
                "NotFoundException",
                f"Table '{name}' not found",
                status_code=404,
            ),
        )
    return bucket, ns, table, None


async def _parse_json_body_or_error(request: Request):  # type: ignore[return]
    """Parse JSON body; return (body_dict, None) or (None, error_response)."""
    try:
        body = await request.json()
        return body, None
    except Exception:
        return None, _error_response("BadRequestException", "Invalid JSON body")


async def _lookup_bucket_parse_body(  # type: ignore[return]
    table_bucket_arn: str, request: Request, state: _S3TablesState
):
    """Return (bucket, body, None) or (None, None, error_response)."""
    bucket, err = _lookup_bucket(table_bucket_arn, state)
    if err is not None:
        return None, None, err
    body, err = await _parse_json_body_or_error(request)
    if err is not None:
        return None, None, err
    return bucket, body, None


async def _create_table_bucket(request: Request, state: _S3TablesState) -> Response:
    """Handle CreateTableBucket (PUT /table-buckets)."""
    body, err = await _parse_json_body_or_error(request)
    if err is not None:
        return err

    name = body.get("name", "")
    if not name:
        return _error_response("BadRequestException", "Table bucket name is required")

    if state.get_bucket(name) is not None:
        return _error_response(
            "ConflictException",
            f"Table bucket '{name}' already exists",
            status_code=409,
        )

    bucket = _TableBucket(name)
    state.table_buckets[bucket.arn] = bucket

    return _json_response(
        {
            "arn": bucket.arn,
        },
        status_code=200,
    )


async def _list_table_buckets(state: _S3TablesState) -> Response:
    """Handle ListTableBuckets (GET /table-buckets)."""
    buckets = []
    for bucket in state.table_buckets.values():
        buckets.append(
            {
                "arn": bucket.arn,
                "name": bucket.name,
                "createdAt": bucket.created_date,
            }
        )

    return _json_response({"tableBuckets": buckets})


async def _get_table_bucket(table_bucket_arn: str, state: _S3TablesState) -> Response:
    """Handle GetTableBucket (GET /table-buckets/{tableBucketARN})."""
    bucket, err = _lookup_bucket(table_bucket_arn, state)
    if err is not None:
        return err

    return _json_response(
        {
            "arn": bucket.arn,
            "name": bucket.name,
            "createdAt": bucket.created_date,
        }
    )


async def _delete_table_bucket(table_bucket_arn: str, state: _S3TablesState) -> Response:
    """Handle DeleteTableBucket (DELETE /table-buckets/{tableBucketARN})."""
    bucket, err = _lookup_bucket(table_bucket_arn, state)
    if err is not None:
        return err
    if bucket.namespaces:
        return _error_response(
            "ConflictException",
            f"Table bucket '{table_bucket_arn}' has active namespaces",
            status_code=409,
        )
    state.table_buckets.pop(bucket.arn, None)
    return Response(status_code=204)


async def _create_namespace(
    table_bucket_arn: str, request: Request, state: _S3TablesState
) -> Response:
    """Handle CreateNamespace (PUT /table-buckets/{tableBucketARN}/namespaces)."""
    bucket, body, err = await _lookup_bucket_parse_body(table_bucket_arn, request, state)
    if err is not None:
        return err

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
    bucket, err = _lookup_bucket(table_bucket_arn, state)
    if err is not None:
        return err

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
    bucket, ns, err = _lookup_bucket_ns(table_bucket_arn, namespace, state)
    if err is not None:
        return err

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
    bucket, ns, err = _lookup_bucket_ns(table_bucket_arn, namespace, state)
    if err is not None:
        return err

    if ns.tables:
        return _error_response(
            "ConflictException",
            f"Namespace '{namespace}' has active tables",
            status_code=409,
        )

    bucket.namespaces.pop(namespace, None)
    return Response(status_code=204)


async def _put_table_policy(
    table_bucket_arn: str, namespace: str, table_name: str, request: Request, state: _S3TablesState
) -> Response:
    """Handle PutTablePolicy."""
    _, _, table, err = _lookup_bucket_ns_table(table_bucket_arn, namespace, table_name, state)
    if err is not None:
        return err
    body, err = await _parse_json_body_or_error(request)
    if err is not None:
        return err
    table.policy = body.get("resourcePolicy", "")
    return _json_response({"resourcePolicy": table.policy})


async def _delete_table_policy(
    table_bucket_arn: str, namespace: str, table_name: str, state: _S3TablesState
) -> Response:
    """Handle DeleteTablePolicy."""
    _, _, table, err = _lookup_bucket_ns_table(table_bucket_arn, namespace, table_name, state)
    if err is not None:
        return err
    if table.policy is None:
        return _error_response(
            "NotFoundException",
            f"No policy found for table '{table_name}'",
            status_code=404,
        )
    table.policy = None
    return Response(status_code=204)


async def _create_table(
    table_bucket_arn: str, namespace: str, request: Request, state: _S3TablesState
) -> Response:
    """Handle CreateTable (PUT /table-buckets/{tableBucketARN}/namespaces/{namespace}/tables)."""
    bucket, ns, err = _lookup_bucket_ns(table_bucket_arn, namespace, state)
    if err is not None:
        return err
    body, err = await _parse_json_body_or_error(request)
    if err is not None:
        return err

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


async def _list_tables(
    table_bucket_arn: str, namespace: str | None, state: _S3TablesState
) -> Response:
    """Handle ListTables (GET /tables/{tableBucketARN})."""
    bucket, err = _lookup_bucket(table_bucket_arn, state)
    if err is not None:
        return err

    if namespace is not None and namespace not in bucket.namespaces:
        return _error_response(
            "NotFoundException",
            f"Namespace '{namespace}' not found in table bucket '{table_bucket_arn}'",
            status_code=404,
        )

    tables = []
    for ns_name, ns in bucket.namespaces.items():
        if namespace is not None and ns_name != namespace:
            continue
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
    _, _, table, err = _lookup_bucket_ns_table(table_bucket_arn, namespace, table_name, state)
    if err is not None:
        return err

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
    _, ns, _, err = _lookup_bucket_ns_table(table_bucket_arn, namespace, table_name, state)
    if err is not None:
        return err
    ns.tables.pop(table_name, None)
    return Response(status_code=204)
