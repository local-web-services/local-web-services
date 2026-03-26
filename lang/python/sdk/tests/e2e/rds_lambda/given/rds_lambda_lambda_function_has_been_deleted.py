"""Given: the Lambda function has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient
from ..constants import TEST_FUNC


@given("the Lambda function has been deleted")
def rds_lambda_lambda_function_has_been_deleted(lws_session):
    try:
        RdsLambdaTestClient(lws_session).create_function()
    except Exception:
        pass
    RdsLambdaTestClient(lws_session)._lambda.delete_function(FunctionName=TEST_FUNC)
