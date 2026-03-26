"""Then: the bucket versioning state is "ENABLED" or "SUSPENDED" non-deterministically"""

from __future__ import annotations

from pytest_bdd import then

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@then('the bucket versioning state is "ENABLED" or "SUSPENDED" non-deterministically')
def bucket_versioning_enabled_or_suspended_then(lws_session):
    client = S3apiTestClient(lws_session).s3()
    resp = client.get_bucket_versioning(Bucket=TEST_BUCKET)
    actual_status = resp.get("Status", "")
    expected_statuses = {"Enabled", "Suspended"}
    assert (
        actual_status in expected_statuses
    ), f"Expected versioning to be one of {expected_statuses} but got '{actual_status}'"
