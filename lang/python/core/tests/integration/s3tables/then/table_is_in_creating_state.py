"""Then: the table is in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE, INT_TABLE


@then('the table is in "CREATING" state')
def table_is_in_creating_state(client: TestClient):
    r = client.get(
        "/get-table",
        params={"tableBucketARN": INT_BUCKET, "namespace": INT_NAMESPACE, "name": INT_TABLE},
    )
    expected_valid_statuses = ("CREATING", "ACTIVE")
    actual_status = r.json().get("status", "ACTIVE")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected table to be CREATING or ACTIVE but got: {actual_status!r}"
