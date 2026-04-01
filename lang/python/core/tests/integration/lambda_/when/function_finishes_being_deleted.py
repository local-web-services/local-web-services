"""When: a "lambda" "function" finishes being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "lambda" "function" finishes being deleted')
def function_finishes_being_deleted(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.get("/2015-03-31/functions")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
