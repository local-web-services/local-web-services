"""Then: the "s3" "bucket" will asynchronously invoke the "lambda" "function" when an "s3" "object" is put"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import FUNC_ARN, TEST_BUCKET


@then(
    'the "s3" "bucket" will asynchronously invoke the "lambda" "function" when an "s3" "object" is put'
)
def bucket_will_invoke_function(lws_session):
    resp = lws_session.client("s3").get_bucket_notification_configuration(Bucket=TEST_BUCKET)
    actual_configs = resp.get("LambdaFunctionConfigurations", [])
    expected_arn = FUNC_ARN
    actual_arns = [cfg.get("LambdaFunctionArn", "") for cfg in actual_configs]
    assert (
        expected_arn in actual_arns
    ), f"Expected notification ARN '{expected_arn}' but found: {actual_arns}"
