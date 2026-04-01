"""Request dispatch helpers for cluster-DB providers (DocumentDB, Neptune)."""

from __future__ import annotations

import json as _json
from typing import Any

from fastapi import Request, Response

from lws.providers._shared._cluster_db_config import ClusterDBConfig
from lws.providers._shared._cluster_db_state import _ClusterDBState
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.request_helpers import (
    parse_json_body,
    parse_query_body,
    resolve_api_action,
)
from lws.providers._shared.response_helpers import (
    error_response as _error_response,
)
from lws.providers._shared.response_helpers import (
    xml_error_response as _xml_error_response,
)
from lws.providers._shared.response_helpers import (
    xml_response as _xml_response,
)


def json_to_xml(action: str, resp: Response) -> Response:
    """Convert a JSON handler response to XML for query-protocol services."""
    try:
        body_data = _json.loads(resp.body)
    except (ValueError, AttributeError):
        body_data = {}
    if "__type" in body_data:
        return _xml_error_response(body_data["__type"], body_data.get("Message", ""))
    return _xml_response(action, body_data, resp.status_code)


async def dispatch_request(
    request: Request,
    config: ClusterDBConfig,
    state: _ClusterDBState,
    action_handlers: dict,
    logger: Any,
    lc: ResourceLifecycleConfig,
    cluster_tracker: ResourceStateTracker,
    instance_tracker: ResourceStateTracker,
    snapshot_tracker: ResourceStateTracker,
    check_cluster_lifecycle: Any,
    check_instance_lifecycle: Any,
    run_with_lifecycle: Any,
) -> Response:
    """Route a single cluster-DB request to the appropriate handler."""
    target = request.headers.get("x-amz-target", "")
    content_type = request.headers.get("content-type", "")
    use_query = config.use_query_protocol and "application/x-www-form-urlencoded" in content_type
    if use_query:
        body = await parse_query_body(request)
    else:
        body = await parse_json_body(request)
    action = resolve_api_action(target, body)

    def wrap(resp: Response) -> Response:
        return json_to_xml(action, resp) if use_query else resp

    err = check_cluster_lifecycle(action, body, lc, cluster_tracker)
    if err is not None:
        return wrap(err)

    err = check_instance_lifecycle(action, body, lc, instance_tracker)
    if err is not None:
        return wrap(err)

    handler = action_handlers.get(action)
    if handler is None:
        logger.warning("Unknown %s action: %s", config.display_name, action)
        resp = _error_response(
            "InvalidAction",
            f"lws: {config.display_name} operation '{action}' is not yet implemented",
        )
        return wrap(resp)

    resp = await run_with_lifecycle(
        handler,
        state,
        body,
        config,
        lc,
        cluster_tracker,
        instance_tracker,
        snapshot_tracker,
        action,
    )
    return wrap(resp)
