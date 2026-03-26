"""When: an object is deleted from a bucket"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@when("an object is deleted from a bucket")
def delete_object(sync_client: TestClient, world):
    r = sync_client.delete(f"/{INT_BUCKET}/{INT_KEY}")
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
