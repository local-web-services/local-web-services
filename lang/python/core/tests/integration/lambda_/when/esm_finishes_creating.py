"""When: an event source mapping finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an event source mapping finishes creating")
def esm_finishes_creating(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.get("/2015-03-31/event-source-mappings")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
