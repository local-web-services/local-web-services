"""When: a "s3" "object" is retrieved from a "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@when('a "s3" "object" is retrieved from a "s3" "bucket"')
def get_object(sync_client: TestClient, world):
    r = sync_client.get(f"/{INT_BUCKET}/{INT_KEY}")
    if r.status_code == 200:
        world["result"] = r.content
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
