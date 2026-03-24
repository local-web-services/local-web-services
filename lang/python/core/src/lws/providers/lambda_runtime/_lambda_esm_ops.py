"""Lambda event source mapping operation handlers."""

from __future__ import annotations

import uuid
from typing import Any

from fastapi import Request, Response

from lws.providers.lambda_runtime._lambda_function_ops import _json_response


def _extract_dynamodb_table_name(event_source_arn: str) -> str | None:
    """Extract the DynamoDB table name from a stream ARN.

    Expected format:
    ``arn:aws:dynamodb:<region>:<account>:table/<table_name>/stream/<timestamp>``
    Returns the table name, or None if the ARN is not a DynamoDB stream ARN.
    """
    if "dynamodb" not in event_source_arn or "/stream/" not in event_source_arn:
        return None
    try:
        table_segment = event_source_arn.split(":table/", 1)[1]
        table_name = table_segment.split("/stream/", 1)[0]
        return table_name
    except (IndexError, ValueError):
        return None


async def _validate_dynamodb_stream_arn(
    event_source_arn: str,
    dynamodb_provider: Any,
    dynamodb_tracker: Any,
) -> Response | None:
    """Validate that a DynamoDB stream ARN references an existing, active, stream-enabled table.

    Returns an error Response if validation fails, or None if validation passes.
    """
    table_name = _extract_dynamodb_table_name(event_source_arn)
    if table_name is None:
        return None

    # Check table exists
    try:
        description = await dynamodb_provider.describe_table(table_name)
    except KeyError:
        return _json_response(
            {
                "message": f"DynamoDB table not found: {table_name}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )

    # Check lifecycle state (CREATING means not yet ACTIVE)
    if dynamodb_tracker is not None:
        status = dynamodb_tracker.get_state(table_name)
        if status == "CREATING":
            return _json_response(
                {
                    "message": f"DynamoDB table '{table_name}' is not yet ACTIVE",
                    "__type": "ResourceInUseException",
                },
                400,
            )

    # Check streams enabled
    stream_spec = description.get("StreamSpecification", {})
    if not stream_spec.get("StreamEnabled", False):
        return _json_response(
            {
                "message": f"DynamoDB table '{table_name}' does not have streaming enabled",
                "__type": "InvalidParameterValueException",
            },
            400,
        )

    return None


async def handle_create_event_source_mapping(
    request: Request,
    event_source_mappings: dict[str, dict[str, Any]],
    dynamodb_provider: Any = None,
    dynamodb_tracker: Any = None,
) -> Response:
    """Handle CreateEventSourceMapping."""
    from lws.providers._shared.request_helpers import (  # pylint: disable=import-outside-toplevel
        parse_json_body,
    )

    body = await parse_json_body(request)
    event_source_arn = body.get("EventSourceArn", "")

    # Validate DynamoDB stream ARN if provider is available
    if dynamodb_provider is not None and "dynamodb" in event_source_arn:
        error_response = await _validate_dynamodb_stream_arn(
            event_source_arn, dynamodb_provider, dynamodb_tracker
        )
        if error_response is not None:
            return error_response

    esm_uuid = str(uuid.uuid4())
    mapping = {
        "UUID": esm_uuid,
        "EventSourceArn": event_source_arn,
        "FunctionArn": body.get("FunctionName", ""),
        "State": "Enabled",
        "BatchSize": body.get("BatchSize", 10),
    }
    event_source_mappings[esm_uuid] = mapping
    return _json_response(mapping, 202)


async def handle_get_event_source_mapping(
    esm_uuid: str,
    event_source_mappings: dict[str, dict[str, Any]],
) -> Response:
    """Handle GetEventSourceMapping."""
    mapping = event_source_mappings.get(esm_uuid)
    if mapping is None:
        return _json_response({"Message": "Not found"}, 404)
    return _json_response(mapping)


async def handle_delete_event_source_mapping(
    esm_uuid: str,
    event_source_mappings: dict[str, dict[str, Any]],
) -> Response:
    """Handle DeleteEventSourceMapping."""
    mapping = event_source_mappings.pop(esm_uuid, None)
    if mapping is None:
        return _json_response({"Message": "Not found"}, 404)
    mapping["State"] = "Deleting"
    return _json_response(mapping, 202)


async def handle_list_event_source_mappings(
    event_source_mappings: dict[str, dict[str, Any]],
) -> Response:
    """Handle ListEventSourceMappings."""
    mappings = list(event_source_mappings.values())
    return _json_response({"EventSourceMappings": mappings})


async def handle_update_event_source_mapping(
    esm_uuid: str,
    request: Request,
    event_source_mappings: dict[str, dict[str, Any]],
) -> Response:
    """Handle UpdateEventSourceMapping."""
    from lws.providers._shared.request_helpers import (  # pylint: disable=import-outside-toplevel
        parse_json_body,
    )

    mapping = event_source_mappings.get(esm_uuid)
    if mapping is None:
        return _json_response({"Message": "Not found"}, 404)
    body = await parse_json_body(request)
    for key in ("BatchSize", "FunctionName", "State"):
        if key in body:
            mapping[key] = body[key]
    return _json_response(mapping)
