"""When: a "s3" "object" is uploaded to a "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BODY, INT_BUCKET, INT_KEY


@when('a "s3" "object" is uploaded to a "s3" "bucket"')
def put_object(sync_client: TestClient, world):
    r = sync_client.put(f"/{INT_BUCKET}/{INT_KEY}", content=INT_BODY)
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
