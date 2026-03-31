"""Given: the rotation function was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient
from ..constants import TEST_FUNC


@given('the rotation function was not "ACTIVE"')
def sm_lambda_function_is_not_active_given(lws_session, world):
    try:
        SecretsmanagerLambdaTestClient(lws_session)._lambda.delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    SecretsmanagerLambdaTestClient(lws_session).create_function()
    world["result"] = None
    world["error"] = None
