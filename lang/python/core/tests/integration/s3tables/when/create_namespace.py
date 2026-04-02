"""When: a "s3 tables" "namespace" is created in a "s3 tables" "bucket" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE


@when('a "s3 tables" "namespace" is created in a "s3 tables" "bucket"')
def create_namespace(client: TestClient, world: dict):
    r = client.put(
        f"/namespaces/{INT_BUCKET}",
        json={"namespace": [INT_NAMESPACE]},
    )
    if r.status_code < 300:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
