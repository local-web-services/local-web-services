"""Then: the object "EXISTS" in the bucket and the execution is "SUCCEEDED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@then('the object "EXISTS" in the bucket and the execution is "SUCCEEDED"')
def object_exists_and_execution_succeeded(lws_session, world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    actual_resp = lws_session.client("s3").get_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
    actual_body = actual_resp["Body"].read()
    expected_body = TEST_BODY
    assert (
        actual_body == expected_body
    ), f"Expected object body {expected_body!r} but got {actual_body!r}"
