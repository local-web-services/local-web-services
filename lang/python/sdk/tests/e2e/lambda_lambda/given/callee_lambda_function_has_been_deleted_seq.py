"""Given: the callee Lambda function has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@given("the callee Lambda function has been deleted")
def callee_lambda_function_has_been_deleted_seq(lws_session):
    try:
        LambdaLambdaTestClient(lws_session).create_function(TEST_CALLEE)
    except Exception:
        pass
    LambdaLambdaTestClient(lws_session).delete_function(FunctionName=TEST_CALLEE)
