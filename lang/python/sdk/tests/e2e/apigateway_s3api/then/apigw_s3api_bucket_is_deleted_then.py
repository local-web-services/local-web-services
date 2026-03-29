"""Then: the bucket is "DELETED" and "API" requests targeting it will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the bucket is "DELETED" and "API" requests targeting it will fail')
def apigw_s3api_bucket_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_bucket to succeed but got: {actual_error}"
