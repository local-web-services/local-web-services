"""When: the list of buckets is retrieved"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient


@when("the list of buckets is retrieved")
def list_buckets(sync_client: TestClient, world):
    r = sync_client.get("/")
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
