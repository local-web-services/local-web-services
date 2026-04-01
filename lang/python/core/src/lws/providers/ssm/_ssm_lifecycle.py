"""SSM Parameter Store lifecycle helpers.

Handles CREATING / DELETING dwell-time states for parameters.
"""

from __future__ import annotations

import json
from typing import Any

from fastapi import Response

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker

_SINGLE_PARAM_READ_ACTIONS = {"GetParameter"}
_MULTI_PARAM_READ_ACTIONS = {"GetParameters"}
_DELETE_SINGLE_ACTION = "DeleteParameter"
_DELETE_MULTI_ACTION = "DeleteParameters"


def _ssm_param_not_found(name: str, param_state: str) -> Response:
    return Response(
        content=json.dumps(
            {
                "__type": "ParameterNotFound",
                "message": f"Parameter {name} not found (status: {param_state})",
            }
        ),
        status_code=400,
        media_type="application/json",
    )


def _ssm_param_still_creating(name: str) -> Response:
    return Response(
        content=json.dumps(
            {
                "__type": "ParameterNotFound",
                "message": f"Parameter {name} is still being created",
            }
        ),
        status_code=400,
        media_type="application/json",
    )


def check_single_param_lifecycle(
    action: str, body: dict, lc: ResourceLifecycleConfig, tracker: ResourceStateTracker
) -> Response | None:
    """Return an error response if a single-read action targets a parameter in a transient state."""
    if not lc.enabled or action not in _SINGLE_PARAM_READ_ACTIONS:
        return None
    name = body.get("Name", "")
    if not name:
        return None
    param_state = tracker.get_state(name)
    if param_state in ("CREATING", "DELETING"):
        return _ssm_param_not_found(name, param_state)
    return None


def check_multi_param_lifecycle(
    action: str, body: dict, lc: ResourceLifecycleConfig, tracker: ResourceStateTracker
) -> Response | None:
    """Return an error response if any named parameter in a multi-read is in a transient state."""
    if not lc.enabled or action not in _MULTI_PARAM_READ_ACTIONS:
        return None
    for name in body.get("Names", []):
        param_state = tracker.get_state(name)
        if param_state in ("CREATING", "DELETING"):
            return _ssm_param_not_found(name, param_state)
    return None


async def lifecycle_put_parameter(
    handler: Any,
    state: Any,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Handle lifecycle for PutParameter. Returns a Response or None to fall through."""
    name = body.get("Name", "")
    overwrite = body.get("Overwrite", False)
    if overwrite and name:
        param_state = tracker.get_state(name)
        if param_state in ("CREATING", "DELETING"):
            return _ssm_param_not_found(name, param_state)
    if lc.create_dwell_ms > 0:
        resp = await handler(state, body)
        if resp.status_code == 200:
            tracker.set_state(name, "CREATING")
            tracker.schedule_transition(name, "ACTIVE", lc.create_dwell_ms)
        return resp
    return None


async def lifecycle_delete_parameter(
    handler: Any,
    state: Any,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteParameter."""
    name = body.get("Name", "")
    if tracker.get_state(name) == "CREATING":
        return _ssm_param_still_creating(name)
    resp = await handler(state, body)
    if resp.status_code == 200:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(name, "DELETING")
            tracker.schedule_transition(name, None, lc.delete_dwell_ms)
        else:
            tracker.remove(name)
    return resp


async def lifecycle_delete_parameters(
    handler: Any,
    state: Any,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteParameters."""
    names = body.get("Names", [])
    for name in names:
        if tracker.get_state(name) == "CREATING":
            return _ssm_param_still_creating(name)
    resp = await handler(state, body)
    if resp.status_code == 200:
        for name in names:
            if lc.delete_dwell_ms > 0:
                tracker.set_state(name, "DELETING")
                tracker.schedule_transition(name, None, lc.delete_dwell_ms)
            else:
                tracker.remove(name)
    return resp


def check_resource_tag_lifecycle(
    body: dict, _lc: ResourceLifecycleConfig, tracker: ResourceStateTracker
) -> Response | None:
    """Return an error response if the tagged resource is in a transient lifecycle state."""
    resource_id = body.get("ResourceId", "")
    resource_type = body.get("ResourceType", "Parameter")
    if resource_type == "Parameter" and resource_id:
        param_state = tracker.get_state(resource_id)
        if param_state in ("CREATING", "DELETING"):
            return Response(
                content=json.dumps(
                    {
                        "__type": "InvalidResourceId",
                        "message": (f"Parameter {resource_id} not found (status: {param_state})"),
                    }
                ),
                status_code=400,
                media_type="application/json",
            )
    return None


async def handle_ssm_lifecycle(
    action: str,
    handler: Any,
    state: Any,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Dispatch to the appropriate lifecycle handler for the given SSM action."""
    if action == "PutParameter":
        return await lifecycle_put_parameter(handler, state, body, lc, tracker)
    if action == _DELETE_SINGLE_ACTION:
        return await lifecycle_delete_parameter(handler, state, body, lc, tracker)
    if action == _DELETE_MULTI_ACTION:
        return await lifecycle_delete_parameters(handler, state, body, lc, tracker)
    if action in ("AddTagsToResource", "ListTagsForResource"):
        return check_resource_tag_lifecycle(body, lc, tracker)
    return None
