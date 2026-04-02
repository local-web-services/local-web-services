"""Given: the subscribed "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient
from ..constants import TEST_FUNC


@given('the "lambda" "function" was not "ACTIVE"')
def sns_lambda_function_is_not_active_given(lws_session, world):
    try:
        SnsLambdaTestClient(lws_session)._lambda.delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    SnsLambdaTestClient(lws_session).create_function()
    world["result"] = None
    world["error"] = None
