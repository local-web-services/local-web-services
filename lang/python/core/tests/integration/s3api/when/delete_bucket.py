"""When: a "s3" "bucket" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@when('a "s3" "bucket" is deleted')
def delete_bucket(sync_client: TestClient, world):
    r = sync_client.delete(f"/{INT_BUCKET}")
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
