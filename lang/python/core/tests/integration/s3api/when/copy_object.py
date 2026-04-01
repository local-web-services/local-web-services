"""When: a "s3" "object" is copied from one "s3" "bucket" to another"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY, INT_KEY2, INT_SRC_BUCKET


@when('a "s3" "object" is copied from one "s3" "bucket" to another')
def copy_object(sync_client: TestClient, world):
    r = sync_client.put(
        f"/{INT_BUCKET}/{INT_KEY2}",
        headers={"x-amz-copy-source": f"/{INT_SRC_BUCKET}/{INT_KEY}"},
    )
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
