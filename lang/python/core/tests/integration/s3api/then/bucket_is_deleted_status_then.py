"""Then: the "s3" "bucket" was "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@then('the "s3" "bucket" will be "DELETED"')
@then('the "s3" "bucket" was "DELETED"')
def bucket_is_deleted_status_then(sync_client: TestClient):
    r = sync_client.get("/")
    actual_body = r.text
    expected_absent = INT_BUCKET
    assert (
        expected_absent not in actual_body
    ), f"Expected bucket '{expected_absent}' to be deleted but it still appears in: {actual_body}"
