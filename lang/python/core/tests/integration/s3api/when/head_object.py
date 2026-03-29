"""When: object metadata is retrieved from a bucket"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@when("object metadata is retrieved from a bucket")
def head_object(sync_client: TestClient, world):
    r = sync_client.head(f"/{INT_BUCKET}/{INT_KEY}")
    if r.status_code == 200:
        world["result"] = dict(r.headers)
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.status_code
