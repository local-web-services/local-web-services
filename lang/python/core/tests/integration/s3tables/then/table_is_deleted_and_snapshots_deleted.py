"""Then: the table is "DELETED" and all its snapshots are "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE, INT_TABLE


@then('the table is "DELETED" and all its snapshots are "DELETED"')
def table_is_deleted_and_snapshots_deleted(client: TestClient):
    r = client.get(
        "/get-table",
        params={"tableBucketARN": INT_BUCKET, "namespace": INT_NAMESPACE, "name": INT_TABLE},
    )
    expected_status_code = 404
    assert (
        r.status_code == expected_status_code
    ), f"Expected table to be deleted but got status {r.status_code}"
