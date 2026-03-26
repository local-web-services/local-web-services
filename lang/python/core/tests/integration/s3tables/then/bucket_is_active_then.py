"""Then: the bucket is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@then('the bucket is "ACTIVE"')
def bucket_is_active_then(client: TestClient):
    r = client.get("/buckets")
    actual_names = [b["name"] for b in r.json().get("tableBuckets", [])]
    expected_bucket = INT_BUCKET
    assert (
        expected_bucket in actual_names
    ), f"Expected bucket '{expected_bucket}' to be present but got: {actual_names}"
