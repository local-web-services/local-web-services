"""
When: the event source mapping polls the stream and invokes the Lambda function with the record
"""

from __future__ import annotations

import time

import pytest
from pytest_bdd import when


@when("the event source mapping polls the stream and invokes the Lambda function with the record")
def esm_polls_and_invokes(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    # Give the stream dispatcher a moment to process
    time.sleep(0.3)
    world["result"] = {"Status": "IN_PROGRESS"}
    world["error"] = None
