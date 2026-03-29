"""When: a table is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE, INT_TABLE


@when("a table is deleted")
def delete_table(client: TestClient, world: dict):
    r = client.delete(f"/tables/{INT_BUCKET}/{INT_NAMESPACE}/{INT_TABLE}")
    if r.status_code < 300:
        world["result"] = None
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
