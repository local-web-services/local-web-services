"""Then: the "s3 tables" "table" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsS3tablesTestClient
from ..constants import TEST_BUCKET


@then('the "s3 tables" "table" will be "ACTIVE"')
def table_is_active_then(lws_session):
    expected_exists = True
    actual_exists = StepfunctionsS3tablesTestClient(lws_session).table_bucket_exists()
    assert (
        actual_exists is expected_exists
    ), f"Expected S3 Tables table bucket '{TEST_BUCKET}' to be ACTIVE but it was not found"
