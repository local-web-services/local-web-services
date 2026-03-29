"""When: a multipart upload is initiated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY, _parse_upload_id


@when("a multipart upload is initiated")
def create_multipart_upload(sync_client: TestClient, world):
    r = sync_client.post(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploads": ""},
    )
    if r.status_code == 200:
        world["upload_id"] = _parse_upload_id(r)
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
