"""Then: the "s3 tables" "table" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE, INT_TABLE


@then('the "s3 tables" "table" will be in "DELETING" state')
def table_enters_deleting_state(client: TestClient):
    r = client.get(
        "/get-table",
        params={
            "tableBucketARN": INT_BUCKET,
            "namespace": INT_NAMESPACE,
            "name": INT_TABLE,
        },
    )
    expected_status_code = 404
    assert (
        r.status_code == expected_status_code
    ), f"Expected table to be absent (deleted) but got status {r.status_code}"
