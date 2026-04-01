"""Given: the "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient
from ..constants import TEST_FUNC


@given('the "lambda" "function" was not "ACTIVE"')
def lambda_s3tables_function_is_not_active_given(lws_session, world):
    try:
        LambdaS3tablesTestClient(lws_session)._lambda.delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    LambdaS3tablesTestClient(lws_session).create_function()
    world["result"] = None
    world["error"] = None
