"""Then: the bucket is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaS3tablesTestClient
from ..constants import TEST_BUCKET


@then('the bucket is "ACTIVE"')
def lambda_s3tables_bucket_is_active_then(lws_session):
    expected_exists = True
    actual_exists = LambdaS3tablesTestClient(lws_session).table_bucket_exists()
    assert (
        actual_exists is expected_exists
    ), f"Expected S3 table bucket '{TEST_BUCKET}' to be ACTIVE but it was not found"
