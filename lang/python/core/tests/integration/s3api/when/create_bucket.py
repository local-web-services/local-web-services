"""When: a bucket is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@when("a bucket is created")
def create_bucket(sync_client: TestClient, world):
    r = sync_client.put(f"/{INT_BUCKET}")
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
