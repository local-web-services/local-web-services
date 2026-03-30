"""When: a namespace is deleted from a table bucket"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE


@when("a namespace is deleted from a table bucket")
def delete_namespace(client: TestClient, world: dict):
    r = client.delete(f"/namespaces/{INT_BUCKET}/{INT_NAMESPACE}")
    if r.status_code < 300:
        world["result"] = None
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
