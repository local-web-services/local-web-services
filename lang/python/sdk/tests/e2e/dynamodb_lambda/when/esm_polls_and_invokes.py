"""
When: the event source mapping polls the stream and invokes the Lambda function with the record
"""

from __future__ import annotations

import time

from pytest_bdd import when


@when("the event source mapping polls the stream and invokes the Lambda function with the record")
def esm_polls_and_invokes(lws_session, world):
    if world.get("esm_exists") is False:
        world["result"] = None
        world["error"] = RuntimeError("ESM poll rejected: event source mapping does not exist.")
        return
    if world.get("stream_record_available") is False:
        world["result"] = None
        world["error"] = RuntimeError(
            "ESM poll rejected: no available record exists in the mapped table's stream."
        )
        return
    if lws_session.capacity("lambda").is_exhausted():
        world["result"] = None
        world["error"] = RuntimeError("ESM poll rejected: no Lambda invocation slot is available.")
        return
    # Give the stream dispatcher a moment to process
    time.sleep(0.3)
    world["result"] = {"Status": "IN_PROGRESS"}
    world["error"] = None
