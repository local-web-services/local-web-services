"""RDS Data API handler — POST /execute via per-cluster in-memory SQLite."""

from __future__ import annotations

import base64
from typing import Any

from fastapi import Response

from lws.providers._shared.response_helpers import (
    error_response as _error_response,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)
from lws.providers.rds._rds_state import _RdsState


def _map_sqlite_value_to_rds(value: Any) -> dict[str, Any]:
    """Map a Python value returned from SQLite to an RDS Data API typed field."""
    if value is None:
        return {"isNull": True}
    if isinstance(value, bool):
        return {"booleanValue": value}
    if isinstance(value, int):
        return {"longValue": value}
    if isinstance(value, float):
        return {"doubleValue": value}
    if isinstance(value, bytes):
        return {"blobValue": base64.b64encode(value).decode()}
    return {"stringValue": str(value)}


def _resolve_cluster_by_arn(state: _RdsState, resource_arn: str):  # noqa: ANN201
    """Return the cluster matching *resource_arn*, or ``None`` if not found."""
    for c in state.clusters.values():
        if c.arn == resource_arn:
            return c
    for c in state.clusters.values():
        if resource_arn.endswith(f":{c.db_cluster_identifier}"):
            return c
    return None


def _resolve_sql_params(parameters: list[dict]) -> list[Any]:
    """Convert RDS typed parameter objects to a flat list of Python values."""
    param_values: list[Any] = []
    for param in parameters:
        value_obj = param.get("value", {})
        if "stringValue" in value_obj:
            param_values.append(value_obj["stringValue"])
        elif "longValue" in value_obj:
            param_values.append(value_obj["longValue"])
        elif "doubleValue" in value_obj:
            param_values.append(value_obj["doubleValue"])
        elif "booleanValue" in value_obj:
            param_values.append(value_obj["booleanValue"])
        else:
            param_values.append(None)
    return param_values


async def handle_execute_statement(state: _RdsState, body: dict) -> Response:
    """Handle RDS Data API ExecuteStatement (POST /execute).

    Executes SQL against the per-cluster in-memory SQLite database.
    """
    resource_arn = body.get("resourceArn", "")
    sql = body.get("sql", "")
    parameters = body.get("parameters", [])

    cluster = _resolve_cluster_by_arn(state, resource_arn)
    if cluster is None:
        return _error_response(
            "BadRequestException",
            f"Cluster not found for resourceArn: {resource_arn}",
            status_code=400,
        )

    conn = await state.get_or_create_cluster_db(cluster.arn)
    param_values = _resolve_sql_params(parameters)

    try:
        cursor = await conn.execute(sql, param_values)
        await conn.commit()
    except Exception as exc:  # noqa: BLE001
        return _error_response(
            "BadRequestException",
            f"SQL execution error: {exc}",
            status_code=400,
        )

    records: list[list[dict]] = []
    number_of_records_updated = cursor.rowcount if cursor.rowcount >= 0 else 0

    if cursor.description:
        rows = await cursor.fetchall()
        for row in rows:
            records.append([_map_sqlite_value_to_rds(col) for col in row])
        number_of_records_updated = 0

    return _json_response(
        {
            "records": records,
            "numberOfRecordsUpdated": number_of_records_updated,
        }
    )
