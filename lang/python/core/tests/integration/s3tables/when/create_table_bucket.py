"""When: a "s3 tables" "bucket" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@when('a "s3 tables" "bucket" is created')
def create_table_bucket(client: TestClient, world: dict):
    r = client.put("/buckets", json={"name": INT_BUCKET})
    if r.status_code < 300:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
