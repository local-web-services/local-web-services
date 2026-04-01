"""Given: the "s3" "upload" has at least one part"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import INT_BODY, INT_BUCKET, INT_KEY


@given('the "s3" "upload" had at least one part')
@given('the "s3" "upload" has at least one part')
def upload_has_at_least_one_part(sync_client: TestClient, world):
    resp = sync_client.put(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"partNumber": "1", "uploadId": world["upload_id"]},
        content=INT_BODY,
    )
    etag = resp.headers.get("ETag", "")
    world.setdefault("etags", []).append({"ETag": etag, "PartNumber": 1})
