"""Given: the mapped function was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient
from ..constants import TEST_FUNC


@given('the "lambda" "function" was not "ACTIVE"')
def dynamodb_lambda_function_is_not_active_given(lws_session, world):
    try:
        DynamodbLambdaTestClient(lws_session)._lambda.delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    DynamodbLambdaTestClient(lws_session).create_function()
    world["result"] = None
    world["error"] = None
    world["_skip"] = (
        "lws does not reject create_event_source_mapping when the Lambda function is in CREATING lifecycle state"  # noqa: E501
    )
