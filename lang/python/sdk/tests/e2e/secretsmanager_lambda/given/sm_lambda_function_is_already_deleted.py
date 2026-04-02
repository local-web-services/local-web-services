"""Given: the "lambda" "function" is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient
from ..constants import TEST_FUNC


@given('the "lambda" "function" is already "DELETED"')
def sm_lambda_function_is_already_deleted(lws_session, world):
    try:
        SecretsmanagerLambdaTestClient(lws_session).create_function()
    except Exception:
        pass
    lws_session.lifecycle("lambda").delete_dwell_ms(5000).apply()
    try:
        SecretsmanagerLambdaTestClient(lws_session)._lambda.delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
    world["result"] = None
    world["error"] = None
