"""When: a table is created in a namespace"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE, INT_TABLE


@when("a table is created in a namespace")
def create_table(client: TestClient, world: dict):
    r = client.put(
        f"/tables/{INT_BUCKET}/{INT_NAMESPACE}",
        json={"name": INT_TABLE, "format": "ICEBERG"},
    )
    if r.status_code < 300:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
