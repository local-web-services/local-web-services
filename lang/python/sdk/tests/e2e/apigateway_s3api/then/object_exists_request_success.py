"""Then: the "s3" "object" will exist and the request will be "SUCCESS" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import then

from ..constants import TEST_BUCKET, TEST_KEY


@then('the "s3" "object" will exist and the request will be "SUCCESS"')
def object_exists_request_success(lws_session, world):
    expected_status = 200
    actual_status = world.get("invoke_status")
    assert (
        actual_status == expected_status
    ), f"Expected request status {expected_status!r} but got {actual_status!r}"
    try:
        lws_session.client("s3").head_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
        object_found = True
    except ClientError:
        object_found = False
    assert (
        object_found
    ), f"Expected object '{TEST_KEY}' in bucket '{TEST_BUCKET}' but it was not found"
