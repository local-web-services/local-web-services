"""S3 Tables maintenance configuration handler functions."""

from __future__ import annotations

from fastapi import Request, Response

from lws.providers.s3tables._s3tables_handlers import (
    _json_response,
    _lookup_bucket_ns_table,
    _lookup_bucket_parse_body,
    _parse_json_body_or_error,
)
from lws.providers.s3tables._s3tables_state import _S3TablesState


async def _put_table_maintenance_configuration(
    table_bucket_arn: str,
    namespace: str,
    name: str,
    maintenance_type: str,
    request: Request,
    state: _S3TablesState,
) -> Response:
    """Handle PutTableMaintenanceConfiguration."""
    _, _, table, err = _lookup_bucket_ns_table(table_bucket_arn, namespace, name, state)
    if err is not None:
        return err
    body, err = await _parse_json_body_or_error(request)
    if err is not None:
        return err
    table.maintenance_configs[maintenance_type] = body.get("value", {})
    return Response(status_code=204)


async def _get_table_maintenance_configuration(
    table_bucket_arn: str,
    namespace: str,
    name: str,
    maintenance_type: str,
    state: _S3TablesState,
) -> Response:
    """Handle GetTableMaintenanceConfiguration."""
    _, _, table, err = _lookup_bucket_ns_table(table_bucket_arn, namespace, name, state)
    if err is not None:
        return err
    config_value = table.maintenance_configs.get(maintenance_type, {})
    return _json_response(
        {
            "tableBucketARN": table_bucket_arn,
            "namespace": namespace,
            "name": name,
            "type": maintenance_type,
            "value": config_value,
        }
    )


async def _start_table_bucket_maintenance(
    table_bucket_arn: str,
    maintenance_type: str,
    request: Request,
    state: _S3TablesState,
) -> Response:
    """Handle StartTableBucketMaintenance."""
    bucket, body, err = await _lookup_bucket_parse_body(table_bucket_arn, request, state)
    if err is not None:
        return err
    bucket.maintenance_configs[maintenance_type] = body.get("value", {})
    return Response(status_code=204)
