"""When: objects in a "s3" "bucket" are listed"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@when('objects in a "s3" "bucket" are listed')
def list_objects_v2(sync_client: TestClient, world):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
