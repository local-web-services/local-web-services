"""When: a multipart upload is completed"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@when("a multipart upload is completed")
def complete_multipart_upload(sync_client: TestClient, world):
    parts = world.get("etags") or []
    parts_xml = "".join(
        f"<Part><PartNumber>{p['PartNumber']}</PartNumber><ETag>{p['ETag']}</ETag></Part>"
        for p in parts
    )
    body = f"<CompleteMultipartUpload>{parts_xml}</CompleteMultipartUpload>"
    r = sync_client.post(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploadId": world.get("upload_id", "invalid")},
        content=body.encode(),
        headers={"Content-Type": "application/xml"},
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
