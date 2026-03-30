"""Then: the bucket is "DELETED" and all its namespaces and tables are "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@then('the bucket is "DELETED" and all its namespaces and tables are "DELETED"')
def bucket_is_deleted_and_all_children_deleted(client: TestClient):
    r = client.get("/buckets")
    actual_names = [b["name"] for b in r.json().get("tableBuckets", [])]
    expected_bucket = INT_BUCKET
    assert (
        expected_bucket not in actual_names
    ), f"Expected bucket '{expected_bucket}' to be deleted but found in: {actual_names}"
