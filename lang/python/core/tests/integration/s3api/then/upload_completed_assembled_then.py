"""Then: the "s3" "upload" will be "COMPLETED" and the assembled "s3" "object" will exist in the "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@then(
    'the "s3" "upload" will be "COMPLETED" and the assembled "s3" "object" will exist in the "s3" "bucket"'
)
def upload_completed_assembled_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    actual_body = r.text
    expected_key = INT_KEY
    assert (
        expected_key in actual_body
    ), f"Expected assembled object '{expected_key}' in bucket listing but got: {actual_body}"
