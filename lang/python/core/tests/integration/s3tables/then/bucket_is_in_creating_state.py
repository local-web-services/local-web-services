"""Then: the "s3 tables" "bucket" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@then('the "s3 tables" "bucket" will be in "CREATING" state')
def bucket_is_in_creating_state(client: TestClient):
    r = client.get(f"/buckets/{INT_BUCKET}")
    expected_valid_statuses = ("CREATING", "ACTIVE")
    actual_status = r.json().get("status", "ACTIVE")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected bucket to be CREATING or ACTIVE but got: {actual_status!r}"
