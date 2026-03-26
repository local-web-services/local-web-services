"""When: an "ACL" deletion completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET


@when('an "ACL" deletion completes')
def acl_deletion_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeACLs"},
        json={},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
