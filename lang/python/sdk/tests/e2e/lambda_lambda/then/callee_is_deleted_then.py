"""Then: the callee is "DELETED" and invocations targeting it will fail"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import then

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@then('the callee is "DELETED" and invocations targeting it will fail')
def callee_is_deleted_then(lws_session):
    try:
        LambdaLambdaTestClient(lws_session).get_function(FunctionName=TEST_CALLEE)
        raise AssertionError(f"Expected callee '{TEST_CALLEE}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_codes = ("ResourceNotFoundException", "404")
        assert (
            error_code in expected_codes
        ), f"Expected 'ResourceNotFoundException' but got: {error_code}"
