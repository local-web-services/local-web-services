"""Then: the "s3 tables" "bucket" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@then('the "s3 tables" "bucket" will be in "DELETING" state')
def bucket_enters_deleting_state(client: TestClient):
    r = client.get("/buckets")
    actual_names = [b["name"] for b in r.json().get("tableBuckets", [])]
    expected_bucket = INT_BUCKET
    assert (
        expected_bucket not in actual_names
    ), f"Expected bucket '{expected_bucket}' to be absent (deleted) but found in: {actual_names}"
