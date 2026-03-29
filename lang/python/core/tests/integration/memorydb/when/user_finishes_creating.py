"""When: a user finishes creating"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_USER_NAME


@when("a user finishes creating")
def user_finishes_creating(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeUsers"},
        json={"UserName": INT_USER_NAME},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
