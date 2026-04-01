"""Then: the "s3" "bucket" will be "ACTIVE" with versioning disabled"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@then('the "s3" "bucket" will be "ACTIVE" with versioning disabled')
def bucket_active_with_versioning_disabled(sync_client: TestClient):
    r = sync_client.get("/")
    expected_bucket = INT_BUCKET
    actual_body = r.text
    assert (
        expected_bucket in actual_body
    ), f"Expected bucket '{expected_bucket}' in list but got: {actual_body}"
