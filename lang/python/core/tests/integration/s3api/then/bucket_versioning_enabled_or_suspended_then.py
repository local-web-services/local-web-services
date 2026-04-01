"""Then: the "s3" "bucket" versioning state will be "ENABLED" or "SUSPENDED" non-deterministically"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@then('the "s3" "bucket" versioning state will be "ENABLED" or "SUSPENDED" non-deterministically')
def bucket_versioning_enabled_or_suspended_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"versioning": ""})
    actual_body = r.text
    expected_valid_statuses = ("Enabled", "Suspended")
    assert any(
        s in actual_body for s in expected_valid_statuses
    ), f"Expected versioning status to be one of {expected_valid_statuses} but got: {actual_body}"
