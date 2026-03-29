"""When: a pending function resolves its deployment"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@when("a pending function resolves its deployment")
def pending_function_resolves(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
