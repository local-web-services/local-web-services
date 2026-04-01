"""When: a part is uploaded for a multipart "glacier" "upload" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BODY, INT_BUCKET, INT_KEY


@when('a part is uploaded for a multipart "s3" "upload"')
@when('a part is uploaded for a multipart "glacier" "upload"')
def upload_part(sync_client: TestClient, world):
    r = sync_client.put(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"partNumber": "1", "uploadId": world.get("upload_id", "invalid")},
        content=INT_BODY,
    )
    if r.status_code == 200:
        etag = r.headers.get("ETag", "")
        world.setdefault("etags", []).append({"ETag": etag, "PartNumber": 1})
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
