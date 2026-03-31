"""Given: the "glacier" "upload" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY, _parse_upload_id


@given('the "s3" "upload" existed')
@given('the "glacier" "upload" existed')
def upload_exists(sync_client: TestClient, world):
    resp = sync_client.post(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploads": ""},
    )
    world["upload_id"] = _parse_upload_id(resp)
    world["etags"] = []
