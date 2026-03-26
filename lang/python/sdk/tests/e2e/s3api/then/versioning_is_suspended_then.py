"""Then: versioning is "SUSPENDED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then('versioning is "SUSPENDED"')
def versioning_is_suspended_then(lws_session):
    client = lws_session.client("s3")
    resp = client.get_bucket_versioning(Bucket=TEST_BUCKET)
    expected_status = "Suspended"
    actual_status = resp.get("Status", "")
    assert (
        actual_status == expected_status
    ), f"Expected versioning to be '{expected_status}' but got '{actual_status}'"
