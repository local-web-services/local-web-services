"""When: a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE


@when('a "s3 tables" "namespace" is deleted from a "s3 tables" "table" s3 tables bucket')
def delete_namespace(client: TestClient, world: dict):
    r = client.delete(f"/namespaces/{INT_BUCKET}/{INT_NAMESPACE}")
    if r.status_code < 300:
        world["result"] = None
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
