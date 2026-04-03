"""RDS lifecycle helpers for modify and describe overlay."""

from __future__ import annotations

import json
from typing import Any

from fastapi import Response

from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    apply_modify_lifecycle,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)

_OVERLAY_SKIP_STATES = {"ACTIVE", "available"}


async def rds_lifecycle_modify_instance(
    handler: Any,
    state: Any,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke modify-instance handler and register MODIFYING state in tracker."""
    iid = body.get("DBInstanceIdentifier", "")
    resp = await handler(state, body)
    return apply_modify_lifecycle(
        resp, iid, lc, tracker, active_state="available", modifying_state="MODIFYING"
    )


def overlay_instance_tracker_state(
    resp: Response,
    tracker: ResourceStateTracker,
) -> Response:
    """Overlay tracker state onto DescribeDBInstances response."""
    if resp.status_code != 200:
        return resp

    data = json.loads(resp.body)
    for inst in data.get("DBInstances", []):
        iid = inst.get("DBInstanceIdentifier", "")
        lc_state = tracker.get_state(iid)
        if lc_state is not None and lc_state not in _OVERLAY_SKIP_STATES:
            inst["DBInstanceStatus"] = lc_state.lower()
    return _json_response(data)
