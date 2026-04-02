"""Then: the "dynamodb" "table" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE, INT_TABLE


@then('the "dynamodb" "table" was "ACTIVE"')
def table_is_active_then(client: TestClient):
    r = client.get(
        "/get-table",
        params={
            "tableBucketARN": INT_BUCKET,
            "namespace": INT_NAMESPACE,
            "name": INT_TABLE,
        },
    )
    expected_status_code = 200
    assert (
        r.status_code == expected_status_code
    ), f"Expected table to be ACTIVE but got status={r.status_code} body={r.json()}"
