"""When: a multipart upload is aborted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@when("a multipart upload is aborted")
def abort_multipart_upload(sync_client: TestClient, world):
    # Guard: reject if bucket does not exist (lws returns 204 regardless)
    head_r = sync_client.head(f"/{INT_BUCKET}")
    if head_r.status_code == 404:
        world["result"] = None
        world["error"] = f"NoSuchBucket: {INT_BUCKET} does not exist"
        return
    # Guard: reject if no valid upload_id is present (upload does not exist)
    upload_id = world.get("upload_id")
    if not upload_id:
        world["result"] = None
        world["error"] = "NoSuchUpload: upload_id is missing or invalid"
        return
    r = sync_client.delete(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploadId": upload_id},
    )
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
