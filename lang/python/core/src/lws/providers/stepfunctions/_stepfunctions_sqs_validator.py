"""SQS task target validation for StepFunctions state machine definitions."""

from __future__ import annotations

import json

from fastapi import Response

from lws.providers._shared.aws_lifecycle import ResourceStateTracker
from lws.providers.stepfunctions._stepfunctions_helpers import _error_response


def check_sqs_task_targets(
    definition: str,
    sqs_provider: object,
    sqs_tracker: ResourceStateTracker | None,
) -> Response | None:
    """Reject if the definition contains SQS tasks referencing a missing or non-ACTIVE queue."""
    if sqs_provider is None:
        return None
    try:
        defn = json.loads(definition) if isinstance(definition, str) else definition
    except (json.JSONDecodeError, Exception):  # noqa: BLE001
        return None
    for state_cfg in defn.get("States", {}).values():
        if state_cfg.get("Resource") != "arn:aws:states:::sqs:sendMessage":
            continue
        queue_url = state_cfg.get("Parameters", {}).get("QueueUrl", "")
        if not queue_url:
            continue
        queue_name = queue_url.rsplit("/", 1)[-1]
        queue = sqs_provider.get_queue(queue_name)  # type: ignore[union-attr]
        if queue is None:
            return _error_response(
                "InvalidDefinition",
                f"SQS queue does not exist: {queue_url}",
            )
        if sqs_tracker is not None:
            sqs_state = sqs_tracker.get_state(queue_name)
            if sqs_state in ("CREATING", "DELETING"):
                return _error_response(
                    "InvalidDefinition",
                    f"SQS queue is not ACTIVE: {queue_url} (status: {sqs_state})",
                )
    return None
