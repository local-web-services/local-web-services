"""When: a function is invoked synchronously without a concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@when("a function is invoked synchronously without a concurrency limit")
def invoke_function_sync_no_limit(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/invocations",
        json={},
    )
    if r.status_code < 300:
        world["result"] = r.json() if r.content else {}
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}
