"""Given: the upload is "IN_PROGRESS" with at least one part uploaded"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import INT_BODY, INT_BUCKET, INT_KEY, _parse_upload_id


@given('the upload is "IN_PROGRESS" with at least one part uploaded')
def upload_in_progress_with_part(sync_client: TestClient, world):
    create_resp = sync_client.post(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploads": ""},
    )
    world["upload_id"] = _parse_upload_id(create_resp)
    part_resp = sync_client.put(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"partNumber": "1", "uploadId": world["upload_id"]},
        content=INT_BODY,
    )
    etag = part_resp.headers.get("ETag", "")
    world["etags"] = [{"ETag": etag, "PartNumber": 1}]
