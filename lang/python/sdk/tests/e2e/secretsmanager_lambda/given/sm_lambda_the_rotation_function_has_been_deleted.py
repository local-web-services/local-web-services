"""Given: the "lambda" "rotation function" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient
from ..constants import TEST_FUNC


@given('the "lambda" "rotation function" is deleted')
def sm_lambda_the_rotation_function_has_been_deleted(lws_session):
    try:
        SecretsmanagerLambdaTestClient(lws_session).create_function()
    except Exception:
        pass
    try:
        SecretsmanagerLambdaTestClient(lws_session)._lambda.delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
