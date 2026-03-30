"""When: an active function is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@when("an active function is deleted")
def delete_active_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.delete(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json()
