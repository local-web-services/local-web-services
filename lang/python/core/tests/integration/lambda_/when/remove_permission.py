"""When: a permission is removed from a function's resource policy"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME, INT_STATEMENT_ID


@when("a permission is removed from a function's resource policy")
def remove_permission(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.delete(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy/{INT_STATEMENT_ID}",
    )
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}
