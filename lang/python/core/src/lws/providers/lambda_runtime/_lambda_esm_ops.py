"""Lambda event source mapping operation handlers."""

from __future__ import annotations

import uuid
from typing import Any

from fastapi import Request, Response

from lws.providers.lambda_runtime._lambda_function_ops import _json_response


async def handle_create_event_source_mapping(
    request: Request,
    event_source_mappings: dict[str, dict[str, Any]],
) -> Response:
    """Handle CreateEventSourceMapping."""
    from lws.providers._shared.request_helpers import (  # pylint: disable=import-outside-toplevel
        parse_json_body,
    )

    body = await parse_json_body(request)
    esm_uuid = str(uuid.uuid4())
    mapping = {
        "UUID": esm_uuid,
        "EventSourceArn": body.get("EventSourceArn", ""),
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
