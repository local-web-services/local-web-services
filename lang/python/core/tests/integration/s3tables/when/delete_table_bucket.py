"""When: a "s3 tables" "table" s3 tables bucket is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@when('a "s3 tables" "table" s3 tables bucket is deleted')
def delete_table_bucket(client: TestClient, world: dict):
    r = client.delete(f"/buckets/{INT_BUCKET}")
    if r.status_code < 300:
        world["result"] = None
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
